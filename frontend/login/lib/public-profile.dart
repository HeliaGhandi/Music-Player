import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/content-display.dart';
import 'dart:math';
import 'package:login/main.dart';

class PublicProfile extends StatefulWidget {
  void Function() backButton;

  PublicProfile({required this.backButton});
  @override
  State<PublicProfile> createState() {
    return _PublicProfileState();
  }
}

class _PublicProfileState extends State<PublicProfile> {
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
            Column(
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
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 25),
                    GestureDetector(
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          image: DecorationImage(
                            image: AssetImage(UserInfo.profilePictureURL),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          UserInfo.username,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                            color:
                                UserInfo.isDark
                                    ? darkTheme.focusColor
                                    : lightTheme.focusColor,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  "2",
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    decoration: TextDecoration.none,
                                    color:
                                        UserInfo.isDark
                                            ? darkTheme.focusColor
                                            : lightTheme.focusColor,
                                  ),
                                ),
                                SizedBox(height: 2), // num of playlists,
                                Text(
                                  "playlists",
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    decoration: TextDecoration.none,
                                    color:
                                        UserInfo.isDark
                                            ? darkTheme.focusColor
                                            : lightTheme.focusColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 45),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  "10",
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    decoration: TextDecoration.none,
                                    color:
                                        UserInfo.isDark
                                            ? darkTheme.focusColor
                                            : lightTheme.focusColor,
                                  ),
                                ),
                                SizedBox(height: 2), // num of playlists,
                                Text(
                                  "followers",
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    decoration: TextDecoration.none,
                                    color:
                                        UserInfo.isDark
                                            ? darkTheme.focusColor
                                            : lightTheme.focusColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 45),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  "10",
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    decoration: TextDecoration.none,
                                    color:
                                        UserInfo.isDark
                                            ? darkTheme.focusColor
                                            : lightTheme.focusColor,
                                  ),
                                ),
                                SizedBox(height: 2), // num of playlists,
                                Text(
                                  "following",
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    decoration: TextDecoration.none,
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
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 28),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "bio :",
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                              color: const Color.fromARGB(225, 158, 158, 158),
                            ),
                          ),

                          SizedBox(height: 5),
                          Text(
                            "hihii hehee",
                            style: GoogleFonts.lato(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
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
                ),
                SizedBox(height: 35),
                Divider(thickness: 2),
                ThisAccountIsPrivate(),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 25),
                Row(
                  children: [
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 13,
                        ),
                        backgroundColor: Colors.transparent,
                        splashFactory: InkRipple.splashFactory,
                        //foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        widget.backButton();
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

class ThisAccountIsPrivate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 150),
        SizedBox(
          child: Container(
            child: Column(
              children: [
                Image.asset(
                  "assets/icons/lock.png",
                  width: 80,
                  height: 80,
                  color:
                      UserInfo.isDark
                          ? darkTheme.focusColor
                          : lightTheme.focusColor,
                ),
                SizedBox(height: 30),
                Text("This Account is private!"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
