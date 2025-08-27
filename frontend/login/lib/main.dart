import 'package:flutter/material.dart';
import 'package:login/account.dart';
import 'package:login/authentication-screens-handler.dart';
import 'package:login/browse-screen.dart';
import 'package:login/change-password.dart';
import 'package:login/chat.dart';
import 'package:login/content-display.dart';
import 'package:login/direct.dart';
import 'package:login/home-screen.dart';
import 'package:login/profile.dart';
import 'package:login/public-profile.dart';
import 'package:login/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/2auth.dart';
import 'package:login/reset-password.dart';
import 'package:login/alzheimer.dart';
import 'package:login/musics.dart';
import 'package:login/music.dart';
import 'package:login/json-handler.dart';

void main() async {
  await Musics.loadMusicsFromServer();
  Musics.extractInfoFromJson();
  await Users.loadAllUsernamesFromServer();
  Users.extractInfoFromUsersJson();


  print(".........");
  print(Musics.musics);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp());
  print(UserInfo.username);
}
// void main() {
//   runApp(MaterialApp(home: TwoAuth(changeToHomePage: () {})));
// }

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isSystemDark = (brightness == Brightness.dark);
    if (UserInfo.isUingSystemPrefrencesAsTheme) {
      UserInfo.isDark = isSystemDark;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      // (UserInfo.username == "NO USERNAME"
      //     // ? Chat(
      //     //   changeToMusic: changeToMusicScreen,
      //     //   changeToDirect: changeToDirect,
      //     //   username: "helia_ghandi",
      //     //   isOnline: true,
      //     // )
      //     ? AuthenticationScreenHandler()
      //     : HomeScreen(
      //       changeToDirect: GoToPathSave.changeToDirect ?? () {},
      //       changeToLibrary: GoToPathSave.changeToLibrary ?? () {},
      //       changeToBrowse: GoToPathSave.changeToBrowse ?? () {},
      //       changeToHome: GoToPathSave.changeToHome ?? () {},
      //       changeToMusicScreen: GoToPathSave.changeToMusicScreen ?? () {},
      //       changeToSettingScreen:
      //           GoToPathSave.changeToSettingScreen ?? () {},
      //     )),
      AuthenticationScreenHandler(
        isUserLoggedIn: !(UserInfo.username != "NO USERNAME"),
      ),
    );
  }
}

class UserInfo {
  static final UserInfo _instance = UserInfo._internal();
  static String username = "NO USERNAME";
  static String firstname = "NO FIRST NAME";
  static String lastname = "NO LAST NAME";
  static String email = "NO EMAIL";
  static String bio = "NO BIO";
  static String currentMusicUrl = "ahle-naa-ahli!shayea.mp3";
  static bool rememberMe = true;
  static bool isDark = true;
  static bool isPrivate = false;
  static String profilePictureURL = "assets/user/profile.png";
  static bool isUingSystemPrefrencesAsTheme = false;
  static List<String> usernamesThatIVEAlreadySharedASongWith = [
    ...Users.usernames,
  ];
  UserInfo._internal();

  factory UserInfo() {
    return _instance;
  }
}

class Util {
  static List<Color> lightThemeColors = [
    const Color.fromRGBO(106, 250, 185, 1),
    const Color.fromRGBO(190, 124, 187, 1),
    const Color.fromRGBO(6, 100, 103, 1),
    const Color.fromRGBO(66, 78, 115, 1),
    const Color.fromRGBO(229, 232, 130, 1),
    Colors.indigo,
    Colors.pink,
    Colors.lightGreenAccent,
    const Color.fromRGBO(96, 64, 160, 1),
    const Color.from(alpha: 1, red: 1, green: 0.373, blue: 0.549),
  ];

  static List<Color> darkThemeColors = [
    const Color.fromRGBO(106, 245, 250, 1),
    const Color.from(alpha: 1, red: 0.796, green: 0.549, blue: 0.922),
    const Color.fromRGBO(126, 237, 193, 1),
    const Color.from(alpha: 1, red: 0.439, green: 0.522, blue: 0.769),
    const Color.fromRGBO(251, 234, 147, 1),
    Colors.indigo,
    const Color.fromRGBO(240, 138, 172, 1),
    const Color.fromRGBO(255, 194, 89, 1),
    const Color.fromRGBO(243, 50, 220, 1),
    const Color.from(alpha: 1, red: 1, green: 0.373, blue: 0.549),
  ];
}

class Users {
  static List<String> usernames = [];
  static String? jsonMessage;
  static loadAllUsernamesFromServer() async {
    // <--- async اضافه شد
    Map<String, String> request = {"command": "USER_LIST", "filter": ""};
    // یک نمونه از JsonHandler ایجاد کرده و متد sendTestRequest را فراخوانی می‌کنیم
    // و منتظر پاسخ آن می‌مانیم.
    Map<String, dynamic> response =
        await JsonHandler(json: request).sendTestRequest(); // <--- تغییر اصلی

    // Handle the case when there are no liked songs or request fails
    if (response["success"] == true && response["message"] != null) {
      jsonMessage = response["message"];
      print(
        jsonMessage!
            .substring(1, jsonMessage!.length - 1)
            .trim()
            .split(", ")
            .toString(),
      );
    } else {
      // No liked songs or request failed, set empty lists
      usernames.clear();
      print("No shared songs found or request failed");
    }
  }

  static void extractInfoFromUsersJson() {
    // Check if likedJsonMessage exists before processing
    if (jsonMessage == null) {
      print("No shared music data available");
      return;
    }

    usernames.clear();

    String data = jsonMessage!.substring(1, jsonMessage!.length - 1);
    usernames = data.trim().split(", ");
  }
}
