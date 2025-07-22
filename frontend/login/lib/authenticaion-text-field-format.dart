import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationTextField extends StatefulWidget {
  final controller;
  String hint;
  Color color;
  double horizontalPadding = 0;
  bool isPassword;
  AuthenticationTextField({
    required this.hint,
    required this.color,
    required this.horizontalPadding,
    required this.isPassword,
    required this.controller,
    super.key,
  });
  @override
  State<StatefulWidget> createState() {
    return _AuthenticationTextFieldState();
  }
}

class _AuthenticationTextFieldState extends State<AuthenticationTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    String hint = widget.hint;
    Color color = widget.color;
    double horizontalPadding = widget.horizontalPadding;
    bool isPassword = widget.isPassword;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        height: 55,
        child: TextFormField(
          controller: widget.controller,
          obscureText: isPassword ? !_isPasswordVisible : false,

          cursorColor: const Color.fromARGB(227, 160, 157, 236),
          style: GoogleFonts.lato(
            color: const Color.fromARGB(248, 255, 255, 255),
          ),
          decoration: InputDecoration(
            suffixIcon:
                isPassword
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible =
                              !_isPasswordVisible; // Update state
                        });
                      },
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    )
                    : null,
            hintText: hint,
            hintStyle: GoogleFonts.lato(
              color: const Color.fromARGB(213, 255, 255, 255),
            ),
            filled: true,
            fillColor: color,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.only(left: 20),
          ),
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }
}
