import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/authenticaion-text-field-format.dart';
import 'package:login/json-handler.dart';

class SignUpPage extends StatefulWidget {
  void Function() changeToLogin;
  SignUpPage({required this.changeToLogin, super.key});

  @override
  State<SignUpPage> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
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
                    controller: firstNameController,
                    hint: "firstname",
                    color: Color.fromARGB(247, 35, 36, 46),
                    horizontalPadding: 20,
                    isPassword: false,
                  ),
                  SizedBox(height: 8),
                  AuthenticationTextField(
                    controller: lastNameController,
                    hint: "lastname",
                    color: Color.fromARGB(247, 35, 36, 46),
                    horizontalPadding: 20,
                    isPassword: false,
                  ),
                  SizedBox(height: 8),
                  AuthenticationTextField(
                    controller: userNameController,
                    hint: "username",
                    color: Color.fromARGB(247, 35, 36, 46),
                    horizontalPadding: 20,
                    isPassword: false,
                  ),
                  SizedBox(height: 8),
                  AuthenticationTextField(
                    controller: emailController,
                    hint: "email",
                    color: Color.fromARGB(247, 35, 36, 46),
                    horizontalPadding: 20,
                    isPassword: false,
                  ),
                  SizedBox(height: 8),
                  AuthenticationTextField(
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
                        // <--- async اضافه شد
                        Map<String, String> request = {
                          "command": "sign_up",
                          "firstname": firstNameController!.text,
                          "lastname": lastNameController!.text,
                          "username": userNameController!.text,
                          "email": emailController!.text,
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
                          // مثلاً:
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
                          print('Login Successful!');
                        } else {
                          print('Login Failed: ${response['message']}');
                          // می‌توانید یک پیام خطا به کاربر نمایش دهید
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
        ],
      ),
    );
  }
}
