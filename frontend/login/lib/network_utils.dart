// import 'dart:io';
// import 'dart:convert';
// import 'dart:async'; // برای استفاده از StreamSubscription

// class NetworkUtils {
//   static const String SERVER_IP = '192.168.43.222';
//   static const int SERVER_PORT = 9090;

//   static Future<Map<String, dynamic>> sendRequest(
//     Map<String, dynamic> requestData,
//   ) async {
//     Socket? socket;
//     try {
//       socket = await Socket.connect(
//         SERVER_IP,
//         SERVER_PORT,
//         timeout: Duration(seconds: 5),
//       );
//       print(
//         'Connected to server: ${socket.remoteAddress.address}:${socket.remotePort}',
//       );

//       String jsonRequest = jsonEncode(requestData);
//       print('Sending JSON: $jsonRequest');

//       socket.writeln(jsonRequest);
//       await socket.flush();

//       // **اصلاح: خواندن کامل داده از سوکت**
//       final completer = Completer<String>();
//       final StringBuffer buffer = StringBuffer();

//       socket.listen(
//         (data) {
//           buffer.write(utf8.decode(data));
//         },
//         onError: (error) {
//           completer.completeError(error);
//         },
//         onDone: () {
//           completer.complete(buffer.toString());
//         },
//         cancelOnError: true,
//       );

//       String jsonResponse = await completer.future.timeout(
//         Duration(seconds: 10),
//       );
//       print('Received JSON: $jsonResponse');

//       Map<String, dynamic> response = jsonDecode(jsonResponse);
//       return response;
//     } on SocketException catch (e) {
//       print('Network Error: $e');
//       return {'success': false, 'message': 'Network error: ${e.message}'};
//     } on TimeoutException catch (e) {
//       print('Connection Timeout: $e');
//       return {'success': false, 'message': 'Connection timeout'};
//     } catch (e) {
//       print('General Error sending request: $e');
//       return {'success': false, 'message': 'An unexpected error occurred: $e'};
//     } finally {
//       if (socket != null) {
//         await socket.close();
//         print('Socket closed.');
//       }
//     }
//   }
// }
