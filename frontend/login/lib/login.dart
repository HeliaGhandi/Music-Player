import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/authenticaion-text-field-format.dart';
import 'package:login/json-handler.dart';
import 'package:login/main.dart';
import 'package:login/notif.dart';
import 'package:login/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/ios-keyboard.dart';
import 'package:login/musics.dart';

class LoginPage extends StatefulWidget {
  void Function() changeToSignUp;
  void Function() changeToHomePage;
  void Function() changeToAlzheimer;
  LoginPage({
    required this.changeToAlzheimer,
    required this.changeToHomePage,
    required this.changeToSignUp,
    super.key,
  });

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool _showCustomKeyboard = false;
  bool _isPasswordField = false;
  Notif? _currentNotif;
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

    return Container(
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
                      SizedBox(width: 40),
                      Text(
                        "Login",
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
                        _isPasswordField = false;
                      });
                    },
                    controller: authController,
                    hint: "username / email",
                    color: Color.fromARGB(247, 35, 36, 46),
                    horizontalPadding: 20,
                    isPassword: false,
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
                    hint: "password",
                    color: Color.fromARGB(247, 35, 36, 46),
                    horizontalPadding: 20,
                    isPassword: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.7,
                          child: Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (bool) {},
                                splashRadius: 0,
                                visualDensity: VisualDensity.compact,
                                activeColor: Colors.white,
                                checkColor: const Color.fromARGB(
                                  255,
                                  255,
                                  7,
                                  230,
                                ),
                              ),
                              Text(
                                "Remember me",

                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 16.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Spacer(),
                        TextButton(
                          style: TextButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                          ),
                          onPressed: () {
                            widget.changeToAlzheimer();
                          },
                          child: Text(
                            "alzheimer?",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 9.4,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 225,
                    child: OutlinedButton(
                      onPressed: () async {
                        // <--- async اضافه شد
                        Map<String, String> request = {
                          "command": "login",
                          "loginCredit": authController!.text,
                          "password": passwordController!.text,
                          "rememberMe": "true",
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
                          Map<String, String> request = {
                            "command": "COMPLETE_INFO",
                            "auth": authController!.text,
                          };
                          // یک نمونه از JsonHandler ایجاد کرده و متد sendTestRequest را فراخوانی می‌کنیم
                          // و منتظر پاسخ آن می‌مانیم.
                          Map<String, dynamic> response =
                              await JsonHandler(
                                json: request,
                              ).sendTestRequest(); // <--- تغییر اصلی
                          UserInfo.firstname = response['firstname'];
                          UserInfo.lastname = response['lastname'];
                          UserInfo.email = response['email'];
                          UserInfo.username = response['username'];
                          print(
                            "User successful login :\nUsername : " +
                                UserInfo.username +
                                "\nFirstname : " +
                                UserInfo.firstname +
                                "\nLastname : " +
                                UserInfo.lastname +
                                "\nemail : " +
                                UserInfo.email,
                          );
                          // مثلاً:
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
                          print('Login Successful!');
                          await Musics.loadLikedMusicsFromServer();

                          Musics.extractInfoFromLikedJson();
                          await Musics.loadSharedMusicsFromServer();
                          Musics.extractInfoFromSharedJson();
                          Notif(
                            text: "login succesful!",
                            finalize: () {
                              setState(() {
                                _currentNotif = null;
                              });
                            },
                          );
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
                          setState(() {
                            _currentNotif = Notif(
                              text: 'Login Failed: ${response['message']} ',
                              finalize: () {
                                setState(() {
                                  _currentNotif = null;
                                });
                              },
                            );
                          });
                          Notif(
                            text: 'Login Failed: ${response['message']} ',
                            color: Color(0xFFD2C3D8),
                            finalize: () {
                              setState(() {
                                _currentNotif = null;
                              });
                            },
                          );
                          // می‌توانید یک پیام خطا به کاربر نمایش دهید
                        }
                      },
                      

                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFFD7B0E6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200),
                        ),

                        foregroundColor: Color(0xFF111130),
                      ),
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(width: 50),
                      Text(
                        "Don't have an account?",
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
                          widget.changeToSignUp();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFF45CC7), // رنگ صورتی مورد نظر
                                width:
                                    1.0, // ضخامت زیرخط (اینجا 2.0 برای چاق‌تر)
                              ),
                            ),
                          ),
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              color: Color(0xFFF45CC7),
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
          if (_currentNotif != null) _currentNotif!,
        ],
      ),
    );
  }
}
