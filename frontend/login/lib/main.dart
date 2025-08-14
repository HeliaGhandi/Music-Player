import 'package:flutter/material.dart';
import 'package:login/authentication-screens-handler.dart';
import 'package:login/home-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/2auth.dart';
import 'package:login/reset-password.dart';
import 'package:login/alzheimer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(
    MyApp(
      changeToBrowse: () {},
      changeToHome: () {},
      changeToMusicScreen: () {},
      changeToSettingScreen: () {},
    ),
  );
  print(UserInfo.username);
}
// void main() {
//   runApp(MaterialApp(home: TwoAuth(changeToHomePage: () {})));
// }

class MyApp extends StatelessWidget {
  final void Function() changeToBrowse;
  final void Function() changeToHome;
  final void Function() changeToMusicScreen;
  final void Function() changeToSettingScreen;

  MyApp({
    Key? key,
    required this.changeToBrowse,
    required this.changeToHome,
    required this.changeToMusicScreen,
    required this.changeToSettingScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          (UserInfo.username == "NO USERNAME"
              ? AuthenticationScreenHandler()
              : HomeScreen(
                changeToBrowse: changeToBrowse,
                changeToHome: changeToHome,
                changeToMusicScreen: changeToMusicScreen,
                changeToSettingScreen: changeToSettingScreen,
              )),
    );
  }
}

class UserInfo {
  static final UserInfo _instance = UserInfo._internal();
  static String username = "NO USERNAME";
  static String firstname = "NO FIRST NAME";
  static String lastname = "NO LAST NAME";
  static String email = "NO EMAIL";
  static bool rememberMe = true;

  UserInfo._internal();

  factory UserInfo() {
    return _instance;
  }
}
