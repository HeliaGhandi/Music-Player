import 'dart:io';
import 'dart:convert';

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
        timeout: Duration(seconds: 5),
      );
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
