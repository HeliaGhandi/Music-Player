import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/content-display.dart';
import 'dart:math';
import 'package:login/main.dart';
import 'package:login/musics.dart';

class Setting extends StatelessWidget {
  void Function() changeToHome;
  void Function() changeToAuth;
  void Function() changeToProfile;
  void Function() changeToAccount;
  void Function() changeToContentAndDisplay;
  void Function() changeToPrivacy;
  Setting({
    required this.changeToHome,
    required this.changeToAuth,
    required this.changeToProfile,
    required this.changeToAccount,
    required this.changeToContentAndDisplay,
    required this.changeToPrivacy,
  });
  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    return Material(
      color:
          UserInfo.isDark
              ? darkTheme.scaffoldBackgroundColor
              : lightTheme.scaffoldBackgroundColor,
      child: Container(
        child: Stack(
          children: [
            // Container(
            //   width: deviceWidth,
            //   height: deviceHeight,
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(color: Colors.black),
            // ),
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
                            UserInfo.isDark
                                ? darkTheme.scaffoldBackgroundColor
                                : lightTheme.scaffoldBackgroundColor,
                        splashFactory: InkRipple.splashFactory,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        changeToHome();
                      },
                      child: Transform.rotate(
                        angle: pi,
                        child: Image.asset(
                          "assets/icons/gosetting.png",
                          color:
                              UserInfo.isDark
                                  ? darkTheme.primaryColor
                                  : lightTheme.primaryColor,
                          width: 20,
                        ),
                      ),
                    ),
                    Text(
                      "Setting",
                      style: GoogleFonts.lato(
                        fontSize: 28,
                        color:
                            UserInfo.isDark
                                ? darkTheme.focusColor
                                : lightTheme.focusColor,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    changeToProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    backgroundColor:
                        UserInfo.isDark
                            ? darkTheme.scaffoldBackgroundColor
                            : lightTheme.scaffoldBackgroundColor,
                    splashFactory: InkRipple.splashFactory,
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize:
                    //     MainAxisSize.min, // keeps button as small as its content
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              image: DecorationImage(
                                image: AssetImage(UserInfo.profilePictureURL),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                UserInfo.firstname,
                                style: GoogleFonts.lato(
                                  fontSize: 22,
                                  color:
                                      UserInfo.isDark
                                          ? darkTheme.focusColor
                                          : lightTheme.focusColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "your profile",
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color:
                                      UserInfo.isDark
                                          ? darkTheme.focusColor
                                          : lightTheme.focusColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Image.asset(
                        "assets/icons/gosetting.png",
                        color:
                            UserInfo.isDark
                                ? darkTheme.primaryColor
                                : lightTheme.primaryColor,
                        width: 20,
                      ),
                    ],
                  ),
                ),
                Button(
                  text: "Account",
                  ontap: () {
                    changeToAccount();
                  },
                ),
                Button(
                  text: "Content & display",
                  ontap: () {
                    changeToContentAndDisplay();
                  },
                ),
                Button(
                  text: "Privacy & social",
                  ontap: () {
                    changeToPrivacy();
                  },
                ),
                SizedBox(height: deviceHeight - 450),
                Button(
                  text: "LOG OUT",
                  ontap: () {
                    changeToAuth();
                    ;
                    Musics.likedMusicArtists = [];
                    Musics.likedMusicNames = [];
                    Musics.likedMusicURLS = [];
                    Musics.likedSongs = [];
                    Musics.sharedMusicArtists = [];
                    Musics.sharedMusicNames = [];
                    Musics.sharedMusicURLS = [];
                    Musics.sharedSongs = [];
                  },

                  // save
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  String text;
  void Function() ontap;
  Color? color;
  bool? isDark;
  Button({required this.text, required this.ontap, this.isDark, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 13),
          backgroundColor:
              UserInfo.isDark
                  ? darkTheme.scaffoldBackgroundColor
                  : lightTheme.scaffoldBackgroundColor,
          splashFactory: InkRipple.splashFactory,
          foregroundColor: Colors.white,
        ),
        onPressed: ontap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.lato(
                fontSize: 18,
                color:
                    color != null
                        ? color
                        : UserInfo.isDark
                        ? darkTheme.focusColor
                        : lightTheme.focusColor,
              ),
            ),
            Image.asset(
              "assets/icons/gosetting.png",
              width: 20,
              color:
                  UserInfo.isDark
                      ? darkTheme.primaryColor
                      : lightTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
