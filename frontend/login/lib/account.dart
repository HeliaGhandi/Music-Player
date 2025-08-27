import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:login/main.dart';
import 'package:login/profile-edit-text-field.dart';
import 'package:login/setting.dart';
import 'package:login/content-display.dart';
import 'package:login/text-input.dart';
import 'package:login/ios-keyboard.dart';
import 'package:login/notif.dart';
import 'package:login/json-handler.dart';
import 'package:login/authentication-screens-handler.dart';

class Account extends StatefulWidget {
  void Function() backToSetting;
  void Function() toChangePassword;
  void Function() toSignUp;
  late bool? isDark;

  Account({
    this.isDark,
    required this.backToSetting,
    required this.toSignUp,
    required this.toChangePassword,
    super.key,
  });
  @override
  State<Account> createState() {
    return _AccountState();
  }
}

class _AccountState extends State<Account> {
  bool _showCustomKeyboard = false;
  TextEditingController? _activeController;
  Notif? _currentNotif;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? userNameController;
  TextEditingController? bioController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    userNameController = TextEditingController();
    bioController = TextEditingController();
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
    return Material(
      color:
          (UserInfo.isDark ?? true
              ? darkTheme.scaffoldBackgroundColor
              : lightTheme.scaffoldBackgroundColor),
      child: Container(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 45),
                Container(
                  child: Row(
                    children: [
                      //SizedBox(width: 20),
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
                          widget.backToSetting();
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
                        "Edit your profile",
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          color:
                              (UserInfo.isDark ?? true
                                  ? darkTheme.primaryColor
                                  : lightTheme.primaryColor),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Stack(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: deviceWidth,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 65),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            GestureDetector(
                              child: Container(
                                width: 85,
                                height: 85,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      (UserInfo.isDark ?? true
                                          ? darkTheme.scaffoldBackgroundColor
                                          : lightTheme.scaffoldBackgroundColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 72),
                        Row(
                          children: [
                            SizedBox(width: 17.5),
                            GestureDetector(
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/user/profile.png",
                                    ),
                                  ),
                                  shape: BoxShape.circle,
                                  color: const Color.fromRGBO(94, 213, 231, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextInput(
                  isDark: UserInfo.isDark,
                  hint: UserInfo.firstname,
                  color: Colors.grey,
                  horizontalPadding: 10,
                  isPassword: false,
                  controller: firstNameController,
                  onTap: () {
                    setState(() {
                      _showCustomKeyboard = true;
                      _activeController = firstNameController;
                    });
                  },
                ),

                TextInput(
                  isDark: UserInfo.isDark,
                  hint: UserInfo.lastname,
                  color: Colors.grey,
                  horizontalPadding: 10,
                  isPassword: false,
                  controller: lastNameController,
                  onTap: () {
                    setState(() {
                      _showCustomKeyboard = true;
                      _activeController = lastNameController;
                    });
                  },
                ),
                TextInput(
                  isDark: UserInfo.isDark,
                  hint: UserInfo.username,
                  color: Colors.grey,
                  horizontalPadding: 10,
                  isPassword: false,
                  controller: userNameController,
                  onTap: () {
                    setState(() {
                      _showCustomKeyboard = true;
                      _activeController = userNameController;
                    });
                  },
                ),
                TextInput(
                  isDark: UserInfo.isDark,
                  hint: UserInfo.email,
                  color: Colors.grey,
                  horizontalPadding: 10,
                  isPassword: false,
                  controller: emailController,

                  onTap: () {
                    setState(() {
                      _showCustomKeyboard = true;
                      _activeController = emailController;
                    });
                  },
                ),
                TextInput(
                  isDark: UserInfo.isDark,
                  hint: UserInfo.bio,
                  color: Colors.grey,
                  horizontalPadding: 10,
                  isPassword: false,
                  controller: bioController,
                  onTap: () {
                    setState(() {
                      _showCustomKeyboard = true;
                      _activeController = bioController;
                    });
                  },
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 300),
                Row(
                  children: [
                    SizedBox(width: 18),
                    Text(
                      "Firstname",
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
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 18),
                    Text(
                      "Lastname",
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
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 18),
                    Text(
                      "Username",
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
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 18),
                    Text(
                      "email",
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
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 18),
                    Text(
                      "bio",
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
                SizedBox(height: 100),
                Row(
                  children: [
                    SizedBox(width: 18),
                    Text(
                      "Security",
                      style: GoogleFonts.labrada(
                        color:
                            (UserInfo.isDark ?? true
                                ? darkTheme.primaryColor
                                : lightTheme.primaryColor),
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Button(
                  text: "Change Password",
                  isDark: UserInfo.isDark,
                  ontap: widget.toChangePassword,
                ),
                SizedBox(height: 5),
                Button(
                  text: "Delete Account",
                  isDark: UserInfo.isDark,
                  ontap: () {
                    setState(() {
                      _currentNotif = Notif(
                        text: "ARE YOU SURE YOU WANT TO DELETE YOU ACCOUNT ? ",
                        doesHaveButton: true,
                        proceedColor: Colors.redAccent,
                        onProceed: () async {
                          //json
                          Map<String, String> request = {
                            "command": "delete_account",
                            "username": UserInfo.username,
                          };

                          // یک نمونه از JsonHandler ایجاد کرده و متد sendTestRequest را فراخوانی می‌کنیم
                          // و منتظر پاسخ آن می‌مانیم.
                          Map<String, dynamic> response =
                              await JsonHandler(
                                json: request,
                              ).sendTestRequest(); // <--- تغییر اصلی
                          print(
                            'Server Response: $response', //yoohoo
                          ); // <--- می‌توانید پاسخ سرور را اینجا چاپ کنید
                          if (response['success'] == true) {
                            setState(() {
                              widget.toSignUp();
                            });
                          }
                        },
                        finalize: () {
                          setState(() {
                            _currentNotif = null;
                          });
                        },
                      );
                    });
                  },
                  color: Colors.red,
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
            if (_currentNotif != null) _currentNotif!,
          ],
        ),
      ),
    );
  }
}
