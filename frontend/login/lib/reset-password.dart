import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/authenticaion-text-field-format.dart';
import 'package:login/json-handler.dart';
import 'package:login/notif.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/ios-keyboard.dart';
import 'package:login/main.dart';

class ResetPassword extends StatefulWidget {
  void Function() changeToHomePage;
  ResetPassword({required this.changeToHomePage, super.key});

  @override
  State<ResetPassword> createState() {
    return _ResetPasswordState();
  }
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _showCustomKeyboard = false;
  bool _isPasswordField = false;
  @override
  void initState() {
    super.initState();
    authController = TextEditingController();
    passwordController = TextEditingController();
  }

  TextEditingController? authController;
  TextEditingController? passwordController;

  void _onKeyTap(String value) {
    final controller = _isPasswordField ? passwordController : authController;
    controller!.text += value;
  }

  void _onBackspace() {
    final controller = _isPasswordField ? passwordController : authController;
    if (controller!.text.isNotEmpty) {
      controller.text = controller.text.substring(
        0,
        controller.text.length - 1,
      );
    }
  }

  void _onReturn() {
    setState(() {
      _showCustomKeyboard = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          "Set new password",
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          "Create a new password",
                          style: GoogleFonts.lato(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    AuthenticationTextField(
                      onTap: () {
                        setState(() {
                          _showCustomKeyboard = true;
                          _isPasswordField = false;
                        });
                      },
                      controller: authController,
                      hint: "Enter your new password",
                      color: Color(0xFF92C2EC),
                      horizontalPadding: 5,
                      isPassword: true,
                    ),
                    SizedBox(height: 10),
                    AuthenticationTextField(
                      onTap: () {
                        setState(() {
                          _showCustomKeyboard = true;
                          _isPasswordField = true; // Corrected this line
                        });
                      },
                      controller: passwordController,
                      hint: "Re-Enter your password",
                      color: Color(0xFF92C2EC),
                      horizontalPadding: 5,
                      isPassword: true,
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      height: 45,
                      width: 225,
                      child: OutlinedButton(
                        onPressed: () async {
                          // <--- async اضافه شد
                          Map<String, String> request = {
                            "command": "FORGOT_PASSWORD",
                            "email": UserInfo.email,
                            "newPassword": authController!.text,
                            "reEnteredNewPassword": passwordController!.text,
                          };
                          // یک نمونه از JsonHandler ایجاد کرده و متد sendTestRequest را فراخوانی می‌کنیم
                          // و منتظر پاسخ آن می‌مانیم.
                          Map<String, dynamic> response =
                              await JsonHandler(
                                json: request,
                              ).sendTestRequest(); // <--- تغییر اصلی
                          print(
                            'Server Response: $response',
                          ); // <--- می‌توانید پاسخ سرور را اینجا چاپ کنید

                          // اینجا می‌توانید بر اساس پاسخ سرور (response) عمل کنید،
                          // مثلاً اگر لاگین موفق بود، کاربر را به صفحه اصلی هدایت کنید.
                          if (response['success'] == true) {
                            // مثلاً:
                            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
                            print('Login Successful!');
                            widget.changeToHomePage();
                            if (response['success'] == true) {
                              // Save the login state
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('isLoggedIn', true);

                              print('Login Successful!');
                              widget.changeToHomePage();
                            }
                          } else {
                            Notif(
                              text: 'Login Failed: ${response['message']} ',
                              color: Color(0xFFD2C3D8),
                            );
                            // می‌توانید یک پیام خطا به کاربر نمایش دهید
                          }
                        },

                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xFF184EEF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(200),
                          ),

                          foregroundColor: Color(0xFF111130),
                          padding: EdgeInsets.symmetric(horizontal: 10),
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
