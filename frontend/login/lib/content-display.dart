import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:login/main.dart';

class ContentDisplay extends StatefulWidget {
  void Function() changeToSetting;
  bool isDark = false;
  ContentDisplay({required this.isDark, required this.changeToSetting});
  @override
  State<ContentDisplay> createState() {
    return _ContentDisplayState();
  }
}

class _ContentDisplayState extends State<ContentDisplay> {
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isSystemDark = (brightness == Brightness.dark);
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: deviceWidth,
              height: deviceHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    (UserInfo.isDark
                        ? darkTheme.scaffoldBackgroundColor
                        : lightTheme.scaffoldBackgroundColor),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 60),
                Row(
                  children: [
                    //SizedBox(width: 20),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 13,
                        ),
                        backgroundColor:
                            (UserInfo.isDark
                                ? darkTheme.scaffoldBackgroundColor
                                : lightTheme.scaffoldBackgroundColor),
                        splashFactory: NoSplash.splashFactory,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.changeToSetting();
                        });
                      },
                      child: Transform.rotate(
                        angle: pi,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 30,
                          color:
                              (UserInfo.isDark
                                  ? darkTheme.primaryColor
                                  : lightTheme.primaryColor),
                        ),
                        // Image.asset(
                        //   "assets/icons/gosetting.png",
                        //   width: 20,
                        // ),
                      ),
                    ),
                    Text(
                      "Display and Content",
                      style: GoogleFonts.lato(
                        fontSize: 28,
                        color:
                            (UserInfo.isDark
                                ? darkTheme.primaryColor
                                : lightTheme.primaryColor),

                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "Display and Brightness",
                      style: GoogleFonts.laila(
                        fontSize: 20,
                        color:
                            (UserInfo.isDark
                                ? darkTheme.primaryColor
                                : lightTheme.primaryColor),

                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "Appearance",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: const Color.fromRGBO(123, 122, 122, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 20),
                          GestureDetector(
                            child: Image.asset(
                              "assets/images/dark.jpg",
                              width: 90,
                              height: 160,
                            ),
                            onTap: () {
                              setState(() {
                                UserInfo.isDark = true;
                                UserInfo.isUingSystemPrefrencesAsTheme = false;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          Text("Dark Theme"),
                          SizedBox(height: 25),
                        ],
                      ),
                      SizedBox(width: 60),
                      Column(
                        children: [
                          SizedBox(height: 20),
                          GestureDetector(
                            child: Image.asset(
                              "assets/images/light.jpg",
                              width: 90,
                              height: 160,
                            ),
                            onTap: () {
                              setState(() {
                                UserInfo.isDark = false;
                                UserInfo.isUingSystemPrefrencesAsTheme = false;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          Text("Light Theme"),
                          SizedBox(height: 25),
                        ],
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(width: 25),
                    Text(
                      "Use System Prefrences",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color:
                            UserInfo.isDark
                                ? darkTheme.focusColor
                                : lightTheme.focusColor,
                      ),
                    ),

                    Transform.scale(
                      scale: 0.75,
                      child: Switch(
                        //focusColor: Colors.greenAccent,
                        //activeColor: const Color.fromARGB(255, 0, 255, 8),
                        value: UserInfo.isUingSystemPrefrencesAsTheme,
                        onChanged: (bool) {
                          setState(() {
                            UserInfo.isDark = isSystemDark;
                            UserInfo.isUingSystemPrefrencesAsTheme =
                                !UserInfo.isUingSystemPrefrencesAsTheme;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color.fromRGBO(1, 35, 49, 1),
  focusColor: Colors.black,
  scaffoldBackgroundColor: Color.fromRGBO(
    198,
    221,
    247,
    1,
  ), // Define other light theme properties like accentColor, textTheme, etc.
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFFB1DAFE),
  focusColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  // Define other dark theme properties like accentColor, textTheme, etc.
);
