import 'package:flutter/material.dart';
import 'package:login/screen.dart';

void main() {
  runApp(MaterialApp(home: (Screen())));
}

// import 'package:flutter/material.dart';
// import 'network_utils.dart'; // import فایل NetworkUtils

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Java Server Test',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _responseText = 'No response yet.';

//   Future<void> _sendTestRequest() async {
//     setState(() {
//       _responseText = 'Sending request...';
//     });
//     try {
//       Map<String, dynamic> response = await NetworkUtils.sendTestRequest();
//       setState(() {
//         _responseText =
//             'Success: ${response['success']}\nMessage: ${response['message']}';
//       });
//       print('Final Response: $_responseText');
//     } catch (e) {
//       setState(() {
//         _responseText = 'Error: $e';
//       });
//       print('Error in UI: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Flutter Java Server Test')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: _sendTestRequest,
//               child: Text('Send Test Request'),
//             ),
//             SizedBox(height: 20),
//             Text(
//               _responseText,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
