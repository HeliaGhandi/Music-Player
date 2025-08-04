import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/recents-musics-button.dart';
import 'package:login/made-for-you-musics-button.dart';

class ScrollableSection extends StatelessWidget {
  String topic;
  double size;
  double space;
  ScrollableSection({
    required this.topic,
    required this.space,
    required this.size,
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
                style: GoogleFonts.lato(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Image.asset("assets/icons/go.png", width: 20),
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
            child: Row(
              children: [
                MadeForYouMusicsButton(size: size, name: "name"),
                SizedBox(width: space),
                MadeForYouMusicsButton(size: size, name: "name"),
                SizedBox(width: space),
                MadeForYouMusicsButton(size: size, name: "name"),
                SizedBox(width: space),
                MadeForYouMusicsButton(size: size, name: "name"),
                SizedBox(width: space),
                MadeForYouMusicsButton(size: size, name: "name"),
                SizedBox(width: space),
                MadeForYouMusicsButton(size: size, name: "name"),
                SizedBox(width: space),
                MadeForYouMusicsButton(size: size, name: "name"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
