import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/recents-musics-button.dart';
import 'package:login/made-for-you-musics-button.dart';
import 'package:login/scrollable-section.dart';
import 'package:login/navigation-bar.dart';
import 'package:login/music-bar.dart';
import 'package:login/content-display.dart';
import 'package:login/main.dart';
import 'package:login/content-display.dart';

class Library extends StatefulWidget {
  void Function() changeToBrowse;
  void Function() changeToHome;
  void Function() changeToMusicScreen;
  void Function() changeToLibrary;

  late bool? isDark;
  Library({
    this.isDark,
    required this.changeToBrowse,
    required this.changeToLibrary , 
    required this.changeToHome,
    required this.changeToMusicScreen,
    super.key,
  });

  State<Library> createState() {
    return _LibraryState();
  }
}

class _LibraryState extends State<Library> {
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
            decoration: BoxDecoration(
              color:
                  (UserInfo.isDark
                      ? darkTheme.scaffoldBackgroundColor
                      : lightTheme.scaffoldBackgroundColor),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 55),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    "Your Library",
                    style: GoogleFonts.poppins(
                      fontSize: 35,
                      decoration: TextDecoration.none,
                      color:
                          (UserInfo.isDark
                              ? darkTheme.focusColor
                              : lightTheme.focusColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Column(
                children: [
                  LibraryCard(playlistName: "aa"),
                  SizedBox(height: 10),
                  LibraryCard(playlistName: "lilk"),
                ],
              ),
              SizedBox(height: 40),
              // SizedBox(
              //   height: deviceHeight - 150,
              //   child:
              // ),
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
                select: 3,
                changeToBrowse: widget.changeToBrowse,
                changeToHome: widget.changeToHome,
                changeToLibrary: widget.changeToLibrary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class MusicCard extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Container(color: ,)

//   }
// }
class LibraryCard extends StatelessWidget {
  String playlistName;
  LibraryCard({required this.playlistName});

  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: deviceWidth - 20,
      height: 100,

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color:
              UserInfo.isDark
                  ? darkTheme.primaryColor
                  : const Color.fromRGBO(19, 75, 147, 1),
        ),
        child: Column(
          children: [
            SizedBox(height: 14.5),
            Row(
              children: [
                SizedBox(width: 20),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.grey,
                    image: DecorationImage(
                      image: AssetImage("assets/covers/am.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      playlistName,
                      style: GoogleFonts.lato(
                        fontSize: 24,
                        decoration: TextDecoration.none,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "26 songs",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        color: const Color.fromRGBO(158, 227, 245, 1),
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
