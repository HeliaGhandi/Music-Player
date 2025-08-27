// import 'package:flutter/material.dart';
// import 'package:login/main.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProfileEditTextField extends StatefulWidget {
//   String text;
//   String info;
//   ProfileEditTextField({required this.text, required this.info, super.key});
//   @override
//   State<ProfileEditTextField> createState() {
//     return _ProfileEditTextFieldState();
//   }
// }

// class _ProfileEditTextFieldState extends State<ProfileEditTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 10,
//       width: 10,
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Text(
//             widget.text,
//             style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
//           ),
//           TextFormField(
//             decoration: InputDecoration(
//               hintText: widget.info,
//               hintStyle: GoogleFonts.lato(
//                 color: const Color.fromARGB(213, 255, 255, 255),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
