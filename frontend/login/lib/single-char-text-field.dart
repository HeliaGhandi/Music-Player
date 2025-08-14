import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/text-input.dart';

class SingleCharTextField extends StatelessWidget {
  void Function() onTap;
  final controller;
  final FocusNode focusNode;
  Color color;
  double horizontalPadding = 0;
  SingleCharTextField({
    required this.onTap,
    required this.color,
    required this.controller,
    required this.focusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 60,
      child: Container(
        decoration: BoxDecoration(color: this.color),
        child: TextFormField(
          focusNode: focusNode,
          onTap: () {
            onTap();
          },
          textAlign: TextAlign.center,
          cursorColor: const Color.fromARGB(227, 160, 157, 236),
          style: GoogleFonts.lato(
            color: const Color.fromARGB(248, 255, 255, 255),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
          controller: this.controller,
          maxLength: 1,
          readOnly: true,
          showCursor: true,
        ),
      ),
    );
  }
}
