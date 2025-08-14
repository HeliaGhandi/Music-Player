import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

class JsonHandler {
  static const String SERVER_IP = '10.0.2.2';
  static const int SERVER_PORT = 9090;
  Map<String, String> json;
  JsonHandler({required this.json});

  Future<Map<String, dynamic>> sendTestRequest() async {
    Socket? socket;
    try {
      socket = await Socket.connect(
        SERVER_IP,
        SERVER_PORT,
        timeout: Duration(seconds: 120),
      );
      socket.setOption(SocketOption.tcpNoDelay, true);

      print(
        'Connected to server: ${socket.remoteAddress.address}:${socket.remotePort}',
      );

      // ساخت درخواست JSON

      String jsonRequest = jsonEncode(json);
      print('Sending JSON: $jsonRequest');

      // ارسال درخواست
      socket.writeln(jsonRequest);
      await socket.flush();

      // خواندن پاسخ
      String jsonResponse = await socket.first.then(
        (data) => utf8.decode(data),
      );
      print('Received JSON: $jsonResponse');

      // تجزیه پاسخ JSON
      Map<String, dynamic> response = jsonDecode(jsonResponse);
      return response;
    } catch (e) {
      print('Error sending request: $e');
      return {'success': false, 'message': 'Network error: $e'};
    } finally {
      if (socket != null) {
        socket.close();
        print('Socket closed.');
      }
    }
  }
}


/// New handler specifically for raw chunk streaming from Java server
class RawChunkStreamHandler {
  final String serverIp;
  final int serverPort;
  final Map<String, String> jsonRequest;

  Socket? _socket;
  String _buffer = '';
  bool _isClosed = false;

  RawChunkStreamHandler({
    required this.serverIp,
    required this.serverPort,
    required this.jsonRequest,
  });

  Future<void> connectAndSend(
    void Function(Uint8List) onChunkReceived, {
    Function()? onDone,
    Function(Object)? onError,
  }) async {
    try {
      print("=== RawChunkStreamHandler.connectAndSend STARTED ===");
      print("Server IP: $serverIp, Port: $serverPort");
      print("JSON Request: $jsonRequest");

      _socket = await Socket.connect(
        serverIp,
        serverPort,
        timeout: Duration(seconds: 60),
      );
      _socket!.setOption(SocketOption.tcpNoDelay, true);

      print(
        'Connected to server: ${_socket!.remoteAddress.address}:${_socket!.remotePort}',
      );

      String requestString = jsonEncode(jsonRequest);
      print('Sending JSON request: $requestString');
      _socket!.writeln(requestString);
      await _socket!.flush();
      print("JSON request sent and flushed");

      // Listen for incoming raw chunks
      print("Setting up socket listener...");
      _socket!.listen(
        (List<int> data) {
          print("=== RAW DATA RECEIVED ===");
          print("Data length: ${data.length} bytes");

          if (_isClosed) {
            print('Handler is closed, ignoring incoming data');
            return;
          }

          try {
            String chunkString = utf8.decode(data);
            print("Decoded string length: ${chunkString.length}");
            print(
              "First 100 chars: ${chunkString.substring(0, chunkString.length > 100 ? 100 : chunkString.length)}",
            );

            _buffer += chunkString;
            print("Buffer length after adding: ${_buffer.length}");

            // Split by newlines to handle complete messages
            List<String> lines = _buffer.split('\n');
            _buffer = lines.removeLast(); // Keep incomplete line in buffer
            print("Split into ${lines.length} lines");

            for (String line in lines) {
              if (line.trim().isEmpty) continue;
              if (_isClosed) break;

              print(
                'Processing line: ${line.substring(0, line.length > 100 ? 100 : line.length)}...',
              );

              try {
                // Decode Base64 and pass raw bytes to callback
                final bytes = base64.decode(line.trim());
                print("Base64 decoded successfully: ${bytes.length} bytes");
                if (!_isClosed) {
                  onChunkReceived(bytes); // ta inja 
                  print("Chunk passed to callback");
                }
              } catch (e) {
                print('Error decoding Base64 chunk: $e');
                if (!_isClosed) {
                  onError?.call(e);
                }
              }
            }
          } catch (e) {
            print('Error processing chunk: $e');
            if (!_isClosed) {
              onError?.call(e);
            }
          }
        },
        onDone: () {
          print('=== SERVER CLOSED CONNECTION ===');
          onDone?.call();
          close();
        },
        onError: (error) {
          print('=== SOCKET ERROR ===');
          print('Socket error details: $error');
          onError?.call(error);
          close();
        },
        cancelOnError: true,
      );
      print("Socket listener set up successfully");
    } catch (e) {
      print('=== CONNECTION ERROR ===');
      print('Connection error details: $e');
      onError?.call(e);
    }

    print("=== RawChunkStreamHandler.connectAndSend COMPLETED ===");
  }

  void close() {
    _isClosed = true;
    _socket?.close();
    _socket = null;
    _buffer = '';
    print('Raw chunk stream handler closed.');
  }
}
