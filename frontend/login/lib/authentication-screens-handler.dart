import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/authentication-screen.dart';
import 'package:login/background-login.dart';
import 'package:login/sign-up.dart';
// Assuming you save the above code in animated_background_widget.dart
import 'package:login/login.dart';

class AuthenticationScreenHandler extends StatefulWidget {
  Widget? activeScreen;
  LoginPage? loginPage;
  @override
  State<AuthenticationScreenHandler> createState() {
    return _AuthenticationScreenHandlerState();
  }

  AuthenticationScreenHandler({this.loginPage, super.key});
}

class _AuthenticationScreenHandlerState
    extends State<AuthenticationScreenHandler> {
  String bluredLoginBackground = "assets/images/blured-login-background.png";
  String backgroundLogin = "assets/images/login-background.png";
  String? activeBackground;
  @override
  initState() {
    activeBackground = backgroundLogin;
    widget.activeScreen = AuthenticationScreen(
      changeToLogin: changeScreenToLogin,
      changeToSignUp: changeScreenToSignUp,
    );
    super.initState();
  }

  void changeScreenToSignUp() {
    setState(() {
      widget.activeScreen = SignUpPage(changeToLogin: changeScreenToLogin);
      activeBackground = bluredLoginBackground;
    });
  }

  void changeScreenToLogin() {
    setState(() {
      widget.activeScreen = LoginPage(changeToSignUp: changeScreenToSignUp);
      activeBackground = bluredLoginBackground;
    });
  }

  void changeScreenToPrivacyPolicy() {}
  void changeScreenToTermsOfService() {}
  void changeScreenToContinueWithGoogle() {}

  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          //GEMENI :
          // The animated background
          AnimatedBackgroundWidget(activeBackground: activeBackground!),

          //Image.asset("assets/images/blured-login-background-t.png"),
          //KHODEMOON :
          //SignUpPage(),
          if (widget.activeScreen != null)
            Center(
              child: SizedBox(
                width: deviceWidth,
                height: deviceHeight,
                child: widget.activeScreen!,
              ),
            ),
          Column(
            children: [
              SizedBox(height: deviceHeight - 60),
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
        ],
      ),
    );
  }
}
