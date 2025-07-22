import 'dart:io';
import 'dart:convert';

class NetworkUtils {
  static const String SERVER_IP =
      '10.0.2.2'; // برای شبیه ساز اندروید از 10.0.2.2 استفاده کنید.
  // برای دستگاه واقعی IP وای فای سرور را وارد کنید.
  // برای شبیه ساز iOS از localhost یا IP سیستم استفاده کنید.
  static const int SERVER_PORT = 9090;

  static Future<Map<String, dynamic>> sendTestRequest() async {
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
      Map<String, String> request = {
        "command": "login",
        "loginCredit": "i.esmaeili@sbu.ac.ir",
        "password": "HELIAHELIA1385",
        "rememberMe": "true",
      };
      String jsonRequest = jsonEncode(request);
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
