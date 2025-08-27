import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/content-display.dart';
import 'package:login/main.dart';
// import 'package:login/ios-keyboard.dart'; // Commented out as it's not provided

class TextInput extends StatefulWidget {
  final controller;
  String hint;
  Color color;
  double horizontalPadding = 0;
  bool isPassword;
  void Function() onTap;
  bool? isDark;

  TextInput({
    this.isDark,
    required this.hint,
    required this.color,
    required this.horizontalPadding,
    required this.isPassword,
    required this.controller,
    required this.onTap,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _TextInputState();
  }
}

class _TextInputState extends State<TextInput> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    String hint = widget.hint;
    Color color = widget.color;
    double horizontalPadding = widget.horizontalPadding;
    bool isPassword = widget.isPassword;

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: SizedBox(
          height: 40,
          width: 145,
          child: TextFormField(
            textAlign: TextAlign.start,
            showCursor: true,
            readOnly: true,
            onTap: () {
              widget.onTap();
            },
            controller: widget.controller,
            obscureText: isPassword ? !_isPasswordVisible : false,
            cursorColor: const Color.fromARGB(227, 160, 157, 236),
            style: GoogleFonts.lato(
              color: const Color.fromARGB(248, 255, 255, 255),
              fontSize: 15,
            ),
            decoration: InputDecoration(
              // REMOVE THE OutlineInputBorder
              // It was overriding all other border settings.

              // Set the border for the normal (enabled) state
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: color, width: 2.0),
              ),

              // Set the border for the focused state
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),

              suffixIcon:
                  isPassword
                      ? IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
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
                color:
                    (UserInfo.isDark ?? true
                        ? darkTheme.focusColor
                        : lightTheme.primaryColor),
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.only(left: 20),
            ),
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }
}
