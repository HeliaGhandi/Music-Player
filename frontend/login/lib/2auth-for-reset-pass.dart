import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/authenticaion-text-field-format.dart';
import 'package:login/json-handler.dart';
import 'package:login/notif.dart';
import 'package:login/single-char-text-field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/ios_numpad.dart';
import 'package:login/main.dart';

class TwoAuthenticationForResetPassword extends StatefulWidget {
  void Function() changeToPassChange;
  Notif? _currentNotif;
  TwoAuthenticationForResetPassword({
    required this.changeToPassChange,
    super.key,
  });
  @override
  State<TwoAuthenticationForResetPassword> createState() {
    return _TwoAuthenticationForResetPasswordState();
  }
}

class _TwoAuthenticationForResetPasswordState
    extends State<TwoAuthenticationForResetPassword> {
  late FocusNode firstFocus;
  late FocusNode secondFocus;
  late FocusNode thirdFocus;
  late FocusNode fourthFocus;

  late String code;
  bool _showCustomKeyboard = false;
  bool _isPasswordField = false;
  @override
  void initState() {
    super.initState();
    firstController = TextEditingController();
    secondController = TextEditingController();
    thirdController = TextEditingController();
    fourthController = TextEditingController();
    passwordController = TextEditingController();
    firstFocus = FocusNode();
    secondFocus = FocusNode();
    thirdFocus = FocusNode();
    fourthFocus = FocusNode();
    fetchCode();
  }

  void dispose() {
    // Dispose focus nodes
    firstFocus.dispose();
    secondFocus.dispose();
    thirdFocus.dispose();
    fourthFocus.dispose();
    super.dispose();
  } //gpt

  TextEditingController? firstController;
  TextEditingController? secondController;
  TextEditingController? thirdController;
  TextEditingController? fourthController;
  TextEditingController? passwordController;

  void _onKeyTap(String value) {
    if (firstFocus.hasFocus && firstController!.text.isEmpty) {
      firstController!.text = value;
      FocusScope.of(context).requestFocus(secondFocus);
    } else if (secondFocus.hasFocus && secondController!.text.isEmpty) {
      secondController!.text = value;
      FocusScope.of(context).requestFocus(thirdFocus);
    } else if (thirdFocus.hasFocus && thirdController!.text.isEmpty) {
      thirdController!.text = value;
      FocusScope.of(context).requestFocus(fourthFocus);
    } else if (fourthFocus.hasFocus && fourthController!.text.isEmpty) {
      fourthController!.text = value;
    }
  }

  void _onBackspace() {
    // Handle backspace for digit fields
    if (fourthFocus.hasFocus) {
      if (fourthController!.text.isNotEmpty) {
        fourthController!.clear();
      } else {
        // If empty, move focus to third field
        FocusScope.of(context).requestFocus(thirdFocus);
      }
    } else if (thirdFocus.hasFocus) {
      if (thirdController!.text.isNotEmpty) {
        thirdController!.clear();
      } else {
        FocusScope.of(context).requestFocus(secondFocus);
      }
    } else if (secondFocus.hasFocus) {
      if (secondController!.text.isNotEmpty) {
        secondController!.clear();
      } else {
        FocusScope.of(context).requestFocus(firstFocus);
      }
    } else if (firstFocus.hasFocus && firstController!.text.isNotEmpty) {
      firstController!.clear();
    }
  }

  void _onReturn() {
    setState(() {
      _showCustomKeyboard = false;
      () async {
        // <--- async اضافه شد
        // <--- می‌توانید پاسخ سرور را اینجا چاپ کنید

        // اینجا می‌توانید بر اساس پاسخ سرور (response) عمل کنید،
        // مثلاً اگر لاگین موفق بود، کاربر را به صفحه اصلی هدایت کنید.
        if (code ==
            (firstController!.text +
                secondController!.text +
                thirdController!.text +
                fourthController!.text)) {
          // مثلاً:
          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
          print("yoooohooo2");
          widget.changeToPassChange();
          if (code ==
              (firstController!.text +
                  secondController!.text +
                  thirdController!.text +
                  fourthController!.text)) {
            // Save the login state
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLoggedIn', true);
            print("yoooohooo");

            widget.changeToPassChange();
          }
        } else {
          Notif(
            finalize: () {
              widget._currentNotif = null;
            },
            text: 'Login Failed',
            color: Color(0xFFD2C3D8),
          );
          // می‌توانید یک پیام خطا به کاربر نمایش دهید
        }
      };
    });
  }

  Future<void> fetchCode() async {
    Map<String, String> request = {
      "command": "two_authentication_recovery",
      "email": UserInfo.email,
    };
    Map<String, dynamic> response =
        await JsonHandler(json: request).sendTestRequest();
    print('Server Response: $response');
    setState(() {
      code = response["message"];
      print("code::" + code);
    });
  }

  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    print(UserInfo.email);
    return Material(
      color: Colors.transparent,
      child: Container(
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0.0, -0.2),
              child: Container(
                width: 320,
                height: 370,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(219, 0, 0, 0),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 45),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "Check your email",
                          style: GoogleFonts.lato(
                            fontSize: 23,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "We sent an email to your account!\nenter the 4-digit code that is mentioned in the email",
                          style: GoogleFonts.lato(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60),

                    // AuthenticationTextField(
                    //   onTap: () {
                    //     setState(() {
                    //       _showCustomKeyboard = true;
                    //       _isPasswordField = false;
                    //     });
                    //   },
                    //   controller: authController,
                    //   hint: "code",
                    //   color: Color.fromARGB(247, 35, 36, 46),
                    //   horizontalPadding: 20,
                    //   isPassword: false,
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SingleCharTextField(
                          focusNode: firstFocus,
                          color: Color.fromARGB(247, 35, 36, 46),
                          controller: firstController,

                          onTap: () {
                            setState(() {
                              _showCustomKeyboard = true;
                              _isPasswordField = false;
                            });
                          },
                        ),
                        SizedBox(width: 20),

                        SingleCharTextField(
                          focusNode: secondFocus,
                          color: Color.fromARGB(247, 35, 36, 46),
                          controller: secondController,

                          onTap: () {
                            setState(() {
                              _showCustomKeyboard = true;
                              _isPasswordField = false;
                            });
                          },
                        ),
                        SizedBox(width: 20),
                        SingleCharTextField(
                          focusNode: thirdFocus,
                          color: Color.fromARGB(247, 35, 36, 46),
                          controller: thirdController,

                          onTap: () {
                            setState(() {
                              _showCustomKeyboard = true;
                              _isPasswordField = false;
                            });
                          },
                        ),
                        SizedBox(width: 20),
                        SingleCharTextField(
                          focusNode: fourthFocus,
                          color: Color.fromARGB(247, 35, 36, 46),
                          controller: fourthController,

                          onTap: () {
                            setState(() {
                              _showCustomKeyboard = true;
                              _isPasswordField = false;
                            });
                          },
                        ),
                      ],
                    ),
                    //replace._._.
                    SizedBox(height: 50),
                    SizedBox(
                      height: 45,
                      width: 225,
                      child: OutlinedButton(
                        onPressed: () async {
                          // <--- async اضافه شد
                          // <--- می‌توانید پاسخ سرور را اینجا چاپ کنید

                          // اینجا می‌توانید بر اساس پاسخ سرور (response) عمل کنید،
                          // مثلاً اگر لاگین موفق بود، کاربر را به صفحه اصلی هدایت کنید.
                          if (code ==
                              (firstController!.text +
                                  secondController!.text +
                                  thirdController!.text +
                                  fourthController!.text)) {
                            // مثلاً:
                            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
                            print("yoooohooo2");
                            widget.changeToPassChange();
                            if (code ==
                                (firstController!.text +
                                    secondController!.text +
                                    thirdController!.text +
                                    fourthController!.text)) {
                              // Save the login state
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('isLoggedIn', true);
                              print("yoooohooo");
                              widget.changeToPassChange();
                            }
                          } else {
                            Notif(
                              finalize: () {
                                setState(() {
                                  widget._currentNotif = null;
                                });
                              },
                              text: 'Login Failed',
                              color: Color(0xFFD2C3D8),
                            );
                            // می‌توانید یک پیام خطا به کاربر نمایش دهید
                          }
                        },

                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 1, 96, 249),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200),
                          ),

                          foregroundColor: Color(0xFF111130),
                        ),
                        child: Text(
                          "Continue",
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            //Notif(text: "test", color: Color(0xFFD2C3D8),),
            Column(
              children: [
                SizedBox(height: deviceHeight - 65),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory, // gham :(
                      ),
                      onPressed: () {},
                      child: Text(
                        "privacy policy",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text("|", style: GoogleFonts.poppins(color: Colors.white)),
                    TextButton(
                      style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {},
                      child: Text(
                        "terms of serive",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (_showCustomKeyboard)
              Align(
                alignment: Alignment.bottomCenter,
                child: IOSNumpad(
                  onKeyTap: _onKeyTap,
                  onBackspace: _onBackspace,
                  onClose: () => setState(() => _showCustomKeyboard = false),
                  onReturn: _onReturn,
                ),
              ),
            if (widget._currentNotif != null) widget._currentNotif!,
          ],
        ),
      ),
    );
  }
}
