import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/2auth-for-reset-pass.dart';
import 'package:login/account.dart';
import 'package:login/alzheimer.dart';
import 'package:login/authentication-screen.dart';
import 'package:login/background-login.dart';
import 'package:login/browse-screen.dart';
import 'package:login/change-password.dart';
import 'package:login/chat.dart';
import 'package:login/content-display.dart';
import 'package:login/direct.dart';
import 'package:login/home-screen.dart';
import 'package:login/library.dart';
import 'package:login/main.dart';
import 'package:login/privacy-social.dart';
import 'package:login/profile.dart';
import 'package:login/reset-password.dart';
import 'package:login/setting.dart';
import 'package:login/sign-up.dart';
import 'package:login/music-screen.dart';
import 'package:login/2auth.dart';
// Assuming you save the above code in animated_background_widget.dart
import 'package:login/login.dart';

class AuthenticationScreenHandler extends StatefulWidget {
  Widget? activeScreen;
  LoginPage? loginPage;
  bool isUserLoggedIn;
  @override
  State<AuthenticationScreenHandler> createState() {
    return _AuthenticationScreenHandlerState();
  }

  AuthenticationScreenHandler({
    this.loginPage,
    required this.isUserLoggedIn,
    super.key,
  });
}

class _AuthenticationScreenHandlerState
    extends State<AuthenticationScreenHandler> {
  String bluredLoginBackground = "assets/images/blured-login-background.png";
  String backgroundLogin = "assets/images/login-background.png";
  String? activeBackground;
  @override
  initState() {
    if (widget.isUserLoggedIn) {
      activeBackground = backgroundLogin;
      widget.activeScreen = AuthenticationScreen(
        changeToLogin: changeScreenToLogin,
        changeToSignUp: changeScreenToSignUp,
      );
    } else {
      widget.activeScreen = HomeScreen(
        changeToDirect: changeToDirect,
        changeToLibrary: changeToLibrary,
        changeToBrowse: changeScreenToBrowse,
        changeToHome: changeScreenToHome,
        changeToMusicScreen: changeScreenToMusicScreen,
        changeToSettingScreen: changeScreenToSetting,
      );
    }

    super.initState();
  }

  void changeScreenToAuth() {
    setState(() {
      widget.activeScreen = AuthenticationScreen(
        changeToSignUp: changeScreenToSignUp,
        changeToLogin: changeScreenToLogin,
      );
    });
  }

  void changeScreenToSignUp() {
    setState(() {
      widget.activeScreen = SignUpPage(
        changeToTwoStepAuth: changeScreenToAuthenticationTwoStep,
        changeToLogin: changeScreenToLogin,
        changeToHomePage: changeScreenToHome,
      );
      activeBackground = bluredLoginBackground;
    });
  }

  void changeScreenToAuthenticationTwoStep() {
    setState(() {
      widget.activeScreen = TwoAuthentication(
        changeToHomePage: changeScreenToHome,
      );
      activeBackground = bluredLoginBackground;
    });
  }

  void changeScreenToAuthenticationTwoStepForResetPassword() {
    setState(() {
      widget.activeScreen = TwoAuthenticationForResetPassword(
        changeToPassChange: changeScreenToResetPassword,
      );
      activeBackground = bluredLoginBackground;
    });
  }

  void changeScreenToLogin() {
    setState(() {
      widget.activeScreen = LoginPage(
        changeToAlzheimer: changeScreenToAlzheimer,
        changeToSignUp: changeScreenToSignUp,
        changeToHomePage: changeScreenToHome,
      );
      activeBackground = bluredLoginBackground;
    });
  }

  void changeScreenToHome() {
    setState(() {
      widget.activeScreen = HomeScreen(
        changeToDirect: changeToDirect,
        changeToLibrary: changeToLibrary,
        changeToSettingScreen: changeScreenToSetting,
        changeToBrowse: changeScreenToBrowse,
        changeToHome: changeScreenToHome,
        changeToMusicScreen: changeScreenToMusicScreen,
      );
    });
  }

  void changeToDirect() {
    setState(() {
      widget.activeScreen = Direct(
        changeToChat: changeToChat,
        changeToHome: changeScreenToHome,
        changeToMusic: changeScreenToMusicScreen,
      );
    });
  }

  void changeToChat() {
    setState(() {
      widget.activeScreen = Chat(
        changeToDirect: changeToDirect,
        changeToMusic: changeScreenToMusicScreen,
      );
    });
  }

  void changeScreenToBrowse() {
    setState(() {
      widget.activeScreen = BrowseScreen(
        changeToLibrary: changeToLibrary,
        changeToHome: changeScreenToHome,
        changeToBrowse: changeScreenToBrowse,
        changeToMusic: changeScreenToMusicScreen,
      );
    });
  }

  void changeScreenToMusicScreen() {
    setState(() {
      widget.activeScreen = MusicScreen(
        changeToHomeScreen: changeScreenToHome,
        name: "no name",
        singer: "no name",
      );
    });
  }

  void changeScreenToSetting() {
    setState(() {
      widget.activeScreen = Setting(
        changeToPrivacy: changeToPrivacy,
        changeToAccount: changeToAccount,
        changeToContentAndDisplay: changeToContentAndDisplay,
        changeToProfile: changeToProfile,
        changeToHome: changeScreenToHome,
        changeToAuth: changeScreenToLogin,
      );
    });
  }

  void changeToLibrary() {
    setState(() {
      widget.activeScreen = Library(
        changeToLibrary: changeToLibrary,
        changeToBrowse: changeScreenToBrowse,
        changeToHome: changeScreenToHome,
        changeToMusicScreen: changeScreenToMusicScreen,
      );
    });
  }

  void changeToPrivacy() {
    setState(() {
      widget.activeScreen = PrivacySocial(
        changeToSetting: changeScreenToSetting,
      );
    });
  }

  void changeToProfile() {
    setState(() {
      widget.activeScreen = Profile(
        changeToSetting: changeScreenToSetting,
        changeToEditProfile: changeToAccount,
      );
    });
  }

  void changeToContentAndDisplay() {
    setState(() {
      widget.activeScreen = ContentDisplay(
        isDark: UserInfo.isDark,
        changeToSetting: changeScreenToSetting,
      );
    });
  }

  void changeToAccount() {
    setState(() {
      widget.activeScreen = Account(
        toSignUp: changeScreenToSignUp,
        backToSetting: changeScreenToSetting,
        toChangePassword: changeToChangePassword,
      );
    });
  }

  void changeToChangePassword() {
    setState(() {
      widget.activeScreen = ChangePassword(backToAcc: changeToAccount);
    });
  }

  void changeScreenToAlzheimer() {
    setState(() {
      widget.activeScreen = Alzheimer(
        changeToTwoAuthForResetPass:
            changeScreenToAuthenticationTwoStepForResetPassword,
      );
    });
    activeBackground = bluredLoginBackground;
  }

  void changeScreenToResetPassword() {
    setState(() {
      widget.activeScreen = ResetPassword(changeToHomePage: changeScreenToHome);
    });
    activeBackground = bluredLoginBackground;
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
          Column(children: [SizedBox(height: deviceHeight - 60)]),
        ],
      ),
    );
  }
}
