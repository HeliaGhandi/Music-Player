import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        children: [
          Container(
            width: deviceWidth,
            height: deviceHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.black),
          ),
          Column(
            children: [
              SizedBox(height: 60),
              Row(
                children: [
                  //SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 13,
                      ),
                      backgroundColor: Colors.black,
                      splashFactory: InkRipple.splashFactory,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Transform.rotate(
                      angle: pi,
                      child: Image.asset(
                        "assets/icons/gosetting.png",
                        width: 20,
                      ),
                    ),
                  ),
                  Text(
                    "Setting",
                    style: GoogleFonts.lato(
                      fontSize: 28,
                      color: const Color(0xFFB1DAFE),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Your action here
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  backgroundColor: Colors.black,
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
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Helia",
                              style: GoogleFonts.lato(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "your profile",
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Image.asset("assets/icons/gosetting.png", width: 20),
                  ],
                ),
              ),
              Button(text: "Account"),
              Button(text: "Content & display"),
              Button(text: "Privacy & social"),
            ],
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  String text;
  Button({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 13),
          backgroundColor: Colors.black,
          splashFactory: InkRipple.splashFactory,
          foregroundColor: Colors.white,
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: GoogleFonts.lato(fontSize: 18)),
            Image.asset("assets/icons/gosetting.png", width: 20),
          ],
        ),
      ),
    );
  }
}
