import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/authenticaion-text-field-format.dart';
import 'package:login/json-handler.dart';
import 'package:login/main.dart';
import 'package:login/ios-keyboard.dart';
import 'package:login/notif.dart';

class SignUpPage extends StatefulWidget {
  void Function() changeToLogin;
  void Function() changeToHomePage;
  void Function() changeToTwoStepAuth;

  SignUpPage({
    required this.changeToTwoStepAuth,
    required this.changeToHomePage,
    required this.changeToLogin,
    super.key,
  });

  @override
  State<SignUpPage> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  Notif? _currentNorif;
  bool _showCustomKeyboard = false;
  TextEditingController? _activeController;

  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? userNameController;
  TextEditingController? passwordController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
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
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Align(
          alignment: const Alignment(0.0, -0.2),
          child: Container(
            width: 320,
            height: 530,
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
                    SizedBox(width: 40),
                    Text(
                      "Registration",
                      style: GoogleFonts.lato(
                        fontSize: 23,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                AuthenticationTextField(
                  onTap: () {
                    setState(() {
                      _showCustomKeyboard = true;
                      _activeController = firstNameController;
                    });
                  },
                  controller: firstNameController,
                  hint: "firstname",
                  color: Color.fromARGB(247, 35, 36, 46),
                  horizontalPadding: 20,
                  isPassword: false,
                ),
                SizedBox(height: 8),
                AuthenticationTextField(
                  onTap: () {
                    setState(() {
                      _showCustomKeyboard = true;
                      _activeController = lastNameController;
                    });
                  },
                  controller: lastNameController,
                  hint: "lastname",
                  color: Color.fromARGB(247, 35, 36, 46),
                  horizontalPadding: 20,
                  isPassword: false,
                ),
                SizedBox(height: 8),
                AuthenticationTextField(
                  onTap: () {
                    setState(() {
                      _showCustomKeyboard = true;
                      _activeController = userNameController;
                    });
                  },
                  controller: userNameController,
                  hint: "username",
                  color: Color.fromARGB(247, 35, 36, 46),
                  horizontalPadding: 20,
                  isPassword: false,
                ),
                SizedBox(height: 8),
                AuthenticationTextField(
                  onTap: () {
                    setState(() {
                      _showCustomKeyboard = true;
                      _activeController = emailController;
                    });
                  },
                  controller: emailController,
                  hint: "email",
                  color: Color.fromARGB(247, 35, 36, 46),
                  horizontalPadding: 20,
                  isPassword: false,
                ),
                SizedBox(height: 8),
                AuthenticationTextField(
                  onTap: () {
                    setState(() {
                      _showCustomKeyboard = true;
                      _activeController = passwordController;
                    });
                  },
                  controller: passwordController,
                  hint: "password",
                  color: Color.fromARGB(247, 35, 36, 46),
                  horizontalPadding: 20,
                  isPassword: true,
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  width: 225,
                  child: OutlinedButton(
                    onPressed: () async {
                      UserInfo.firstname = firstNameController!.text;
                      UserInfo.lastname = lastNameController!.text;
                      UserInfo.username = userNameController!.text;
                      UserInfo.email = emailController!.text;

                      Map<String, String> request = {
                        "command": "sign_up",
                        "firstname": firstNameController!.text,
                        "lastname": lastNameController!.text,
                        "username": userNameController!.text,
                        "email": emailController!.text,
                        "password": passwordController!.text,
                        "rememberMe": "true",
                      };
                      Map<String, dynamic> response =
                          await JsonHandler(json: request).sendTestRequest();
                      print('Server Response: $response');

                      if (response['success'] == true) {
                        print('Sign up Successful!');
                        widget.changeToTwoStepAuth(); //,,,,,
                      } else {
                        setState(() {
                          _currentNorif = Notif(
                            text: 'Sign up Failed: ${response['message']}',
                            finalize: () {
                              setState(() {
                                _currentNorif = null;
                              });
                            },
                          );
                        });
                        print('Sign up Failed: ${response['message']}');
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xFF7BFFFD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      ),
                      foregroundColor: Color(0xFF111130),
                    ),
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(width: 50),
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.lato(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        widget.changeToLogin();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF2C6FF6),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF2C6FF6),
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(height: deviceHeight - 65),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
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
        if (_currentNorif != null) _currentNorif!,
      ],
    );
  }
}
