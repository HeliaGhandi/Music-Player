import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/content-display.dart';
import 'package:login/main.dart';
import 'package:login/recents-musics-button.dart';
import 'package:login/made-for-you-musics-button.dart';
import 'package:login/musics.dart';

class ScrollableSection extends StatelessWidget {
  String topic;
  double size;
  double space;
  bool? isDark;
  List<Widget> content = [];
  ScrollableSection({
    required this.topic,
    required this.space,
    required this.size,
    required this.content,
  });
  @override
  Widget build(BuildContext context) {
    double madeForYouSpace = size;
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                topic,
                textAlign: TextAlign.center,

                style: GoogleFonts.lato(
                  color:
                      UserInfo.isDark
                          ? darkTheme.focusColor
                          : lightTheme.focusColor,
                  decoration: TextDecoration.none,
                  fontSize: 30,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Image.asset(
                  "assets/icons/go.png",
                  color:
                      (UserInfo.isDark
                          ? darkTheme.focusColor
                          : lightTheme.focusColor),
                  width: 20,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),

        SizedBox(
          width: deviceWidth,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            scrollDirection: Axis.horizontal,
            child: Row(children: content),
          ),
        ),
      ],
    );
  }
}
