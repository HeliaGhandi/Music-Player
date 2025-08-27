import 'package:flutter/material.dart';
import 'dart:math';
import 'package:login/content-display.dart';
import 'package:login/main.dart';
import 'package:login/text-input.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/ios-keyboard.dart';

class ChangePassword extends StatefulWidget {
  bool? isDark;
  void Function() backToAcc;
  ChangePassword({required this.backToAcc, this.isDark, super.key});
  @override
  State<ChangePassword> createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _showCustomKeyboard = false;

  TextEditingController? _activeController;

  TextEditingController? currentPassword;
  TextEditingController? newPassword;
  TextEditingController? reTypeNewPassword;

  @override
  void initState() {
    super.initState();
    currentPassword = TextEditingController();
    newPassword = TextEditingController();
    reTypeNewPassword = TextEditingController();
  }

  void _onKeyTap(String value) {
    if (_activeController != null) {
      _activeController!.text += value;
    }
  }

  void _onBackspace() {
    if (_activeController != null && _activeController!.text.isNotEmpty) {
      _activeController!.text = _activeController!.text.substring(
        0,
        _activeController!.text.length - 1,
      );
    }
  }

  void _onReturn() {
    setState(() {
      _showCustomKeyboard = false;
      _activeController = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          (UserInfo.isDark ?? true
              ? darkTheme.scaffoldBackgroundColor
              : lightTheme.scaffoldBackgroundColor),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 60),
                Row(
                  children: [
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 13,
                        ),
                        backgroundColor:
                            (UserInfo.isDark ?? true
                                ? darkTheme.scaffoldBackgroundColor
                                : lightTheme.scaffoldBackgroundColor),
                        splashFactory: InkRipple.splashFactory,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        widget.backToAcc();
                      },
                      child: Transform.rotate(
                        angle: pi,
                        child: Image.asset(
                          "assets/icons/gosetting.png",
                          color:
                              (UserInfo.isDark ?? true
                                  ? darkTheme.primaryColor
                                  : lightTheme.primaryColor),
                          width: 20,
                        ),
                      ),
                    ),
                    Text(
                      "Change Password",
                      style: GoogleFonts.lato(
                        fontSize: 24,
                        color:
                            (UserInfo.isDark ?? true
                                ? darkTheme.primaryColor
                                : lightTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 75),
                Row(
                  children: [
                    SizedBox(width: 215),
                    TextInput(
                      isDark: UserInfo.isDark,
                      hint: "your password",
                      color: Colors.grey,
                      horizontalPadding: 10,
                      isPassword: false,
                      controller: currentPassword,
                      onTap: () {
                        setState(() {
                          _showCustomKeyboard = true;
                          _activeController = currentPassword;
                        });
                      },
                    ),
                  ],
                ),

                Row(
                  children: [
                    SizedBox(width: 215),
                    TextInput(
                      isDark: UserInfo.isDark,
                      hint: "new password",
                      color: Colors.grey,
                      horizontalPadding: 10,
                      isPassword: false,
                      controller: newPassword,
                      onTap: () {
                        setState(() {
                          _showCustomKeyboard = true;
                          _activeController = newPassword;
                        });
                      },
                    ),
                  ],
                ),

                Row(
                  children: [
                    SizedBox(width: 215),
                    TextInput(
                      isDark: UserInfo.isDark,
                      hint: "re-type password",
                      color: Colors.grey,
                      horizontalPadding: 10,
                      isPassword: false,
                      controller: reTypeNewPassword,
                      onTap: () {
                        setState(() {
                          _showCustomKeyboard = true;
                          _activeController = reTypeNewPassword;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 200),
                Row(
                  children: [
                    SizedBox(width: 35),
                    Text(
                      "current password",
                      style: GoogleFonts.labrada(
                        color:
                            (UserInfo.isDark ?? true
                                ? darkTheme.primaryColor
                                : lightTheme.primaryColor),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(width: 35),
                    Text(
                      "new password",
                      style: GoogleFonts.labrada(
                        color:
                            (UserInfo.isDark ?? true
                                ? darkTheme.primaryColor
                                : lightTheme.primaryColor),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(width: 35),
                    Text(
                      "re-type password",
                      style: GoogleFonts.labrada(
                        color:
                            (UserInfo.isDark ?? true
                                ? darkTheme.primaryColor
                                : lightTheme.primaryColor),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 50),
                OutlinedButton(
                  onPressed: () async {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                        (UserInfo.isDark ?? true
                            ? Color.fromARGB(255, 123, 204, 255)
                            : const Color.fromRGBO(63, 90, 169, 1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    foregroundColor:
                        (UserInfo.isDark ?? true ? Colors.black : Colors.white),
                  ),

                  child: Text(
                    "Change Password",
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                ),
              ],
            ),
            if (_showCustomKeyboard)
              Align(
                alignment: Alignment.bottomCenter,
                child: IOSKeyboard(
                  onKeyTap: _onKeyTap,
                  onBackspace: _onBackspace,
                  onClose: () => setState(() => _showCustomKeyboard = false),
                  onReturn: _onReturn,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

                // Container(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       SizedBox(width: 18),
                //       Text(
                //         "current password",
                //         style: GoogleFonts.labrada(
                //           color: Colors.white,
                //           fontSize: 20,
                //         ),
                //       ),
                //       SizedBox(width: 25),
                //       TextInput(
                //         hint: "your password",
                //         color: Colors.grey,
                //         horizontalPadding: 10,
                //         isPassword: false,
                //         controller: usernameController,
                //         onTap: () {},
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 15),
                // Container(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       SizedBox(width: 18),
                //       Text(
                //         "new password",
                //         style: GoogleFonts.labrada(
                //           color: Colors.white,
                //           fontSize: 20,
                //         ),
                //       ),
                //       SizedBox(width: 25),
                //       TextInput(
                //         hint: "your password",
                //         color: Colors.grey,
                //         horizontalPadding: 10,
                //         isPassword: true,
                //         controller: usernameController,
                //         onTap: () {},
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 15),

                // Container(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       SizedBox(width: 18),
                //       Text(
                //         "current password",
                //         style: GoogleFonts.labrada(
                //           color: Colors.white,
                //           fontSize: 20,
                //         ),
                //       ),
                //       SizedBox(width: 25),
                //       TextInput(
                //         hint: "your password",
                //         color: Colors.grey,
                //         horizontalPadding: 10,
                //         isPassword: true,
                //         controller: usernameController,
                //         onTap: () {},
                //       ),
                //     ],
                //   ),
                // ),