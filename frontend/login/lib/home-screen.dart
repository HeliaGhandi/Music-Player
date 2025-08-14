import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/recents-musics-button.dart';
import 'package:login/made-for-you-musics-button.dart';
import 'package:login/scrollable-section.dart';
import 'package:login/navigation-bar.dart';
import 'package:login/music-bar.dart';

class HomeScreen extends StatefulWidget {
  void Function() changeToBrowse;
  void Function() changeToHome;
  void Function() changeToMusicScreen;
  void Function() changeToSettingScreen;
  HomeScreen({
    required this.changeToBrowse,
    required this.changeToHome,
    required this.changeToMusicScreen,
    required this.changeToSettingScreen,
    super.key,
  });

  State<HomeScreen> createState() {
    return _HomeScreenWidget();
  }
}

class _HomeScreenWidget extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double madeForYouSpace = 20;
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
              SizedBox(height: 55),
              Row(
                children: [
                  SizedBox(width: 20),
                  GestureDetector(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      widget.changeToSettingScreen();
                    },
                  ),
                  SizedBox(width: deviceWidth - 120),

                  GestureDetector(
                    child: Image.asset("assets/icons/icon.png", width: 35),
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                height: deviceHeight - 150,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Text(
                            "Recents",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RecentsMusicsButton(
                            size: 100,
                            name: "AM",
                            cover: "assets/covers/am.jpg",
                          ),
                          SizedBox(width: 25),
                          RecentsMusicsButton(
                            size: 100,
                            name: "EBI",
                            cover: "assets/covers/ebi.jpg",
                          ),
                          SizedBox(width: 25),
                          RecentsMusicsButton(
                            size: 100,
                            name: "Googoosh",
                            cover: "assets/covers/googoosh.jpg",
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RecentsMusicsButton(
                            size: 100,
                            name: "EILISH",
                            cover: "assets/covers/billie.jpg",
                          ),
                          SizedBox(width: 25),
                          RecentsMusicsButton(
                            size: 100,
                            name: "HIRA",
                            cover: "assets/covers/shayea.jpeg",
                          ),
                          SizedBox(width: 25),
                          RecentsMusicsButton(
                            size: 100,
                            name: "heli",
                            cover: "assets/covers/heliyom.jpg",
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      ScrollableSection(
                        topic: "Made For You",
                        size: 100,
                        space: 20,
                      ),
                      SizedBox(height: 30),
                      ScrollableSection(
                        topic: "New Released",
                        size: 150,
                        space: 25,
                      ),
                      SizedBox(height: 30),
                      ScrollableSection(topic: "On Fire", size: 100, space: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 14.5),
              SizedBox(height: deviceHeight - 180),
              // Use CachedMusicBar for enhanced music playback with caching
              CachedMusicBar(changeToFullScreen: widget.changeToMusicScreen),
              // Or use the original MusicBar for JSON-based streaming:
              // MusicBar(changeToFullScreen: widget.changeToMusicScreen),
              SizedBox(height: 5),
              NavigationBari(
                select: 1,
                changeToBrowse: widget.changeToBrowse,
                changeToHome: widget.changeToHome,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
