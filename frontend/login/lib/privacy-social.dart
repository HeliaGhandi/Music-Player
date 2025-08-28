import 'package:flutter/material.dart';
import 'package:login/main.dart';
import 'package:login/content-display.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:login/json-handler.dart';

class PrivacySocial extends StatefulWidget {
  void Function() changeToSetting;
  PrivacySocial({required this.changeToSetting});
  @override
  State<PrivacySocial> createState() {
    // TODO: implement createState
    return _PrivacySocialState();
  }
}

class _PrivacySocialState extends State<PrivacySocial> {
  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:
          (UserInfo.isDark
              ? darkTheme.scaffoldBackgroundColor
              : lightTheme.scaffoldBackgroundColor),
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
                        widget.changeToSetting();
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
                      "Privacy and Social",
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
                SizedBox(height: 25),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SizedBox(width: 25),
                      Text(
                        "Private Account",
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
                          value: UserInfo.isPrivate,
                          onChanged: (bool) {
                            setState(() {
                              UserInfo.isPrivate = !UserInfo.isPrivate;
                            });
                            setState(() async {
                              Map<String, String> request = {
                                "command": "PRIVATE_ACCOUNT",
                                "username": UserInfo.username,
                                "makePrivate":
                                    (UserInfo.isPrivate ? "true" : "false"),
                              };
                             
                              Map<String, dynamic> response =
                                  await JsonHandler(
                                    json: request,
                                  ).sendTestRequest(); 
                              print('Server Response: $response');
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "When your account is public , your Playlists can be seen by anyone even if they dont have an account.\nWhen your account is private, only the followers you approve can see you..",
                    style: GoogleFonts.notoSansElbasan(
                      fontSize: 13,
                      color:
                          UserInfo.isDark
                              ? darkTheme.focusColor
                              : lightTheme.focusColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
