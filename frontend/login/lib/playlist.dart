import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/music.dart';
import 'package:login/playlist-music-bar.dart';
import 'package:login/recents-musics-button.dart';
import 'package:login/made-for-you-musics-button.dart';
import 'package:login/scrollable-section.dart';
import 'package:login/navigation-bar.dart';
import 'package:login/music-bar.dart';
import 'package:login/content-display.dart';
import 'package:login/main.dart';
import 'package:login/content-display.dart';
import 'package:login/library.dart';
import 'package:login/sharePlayList.dart';

class PlaylistScreen extends StatefulWidget {
  PlayList playList;
  SharePlayList? sharePlayList;
  void Function() backToLibrary;
  void Function() changeToMusicScreen;
  PlaylistScreen({
    required this.playList,
    required this.backToLibrary,
    required this.changeToMusicScreen,
  });
  @override
  State<PlaylistScreen> createState() {
    // TODO: implement createState
    return _PlaylistScreenState();
  }
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
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
                      widget.backToLibrary();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
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
                ],
              ),

              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey,
                  image: DecorationImage(
                    image: AssetImage("assets/covers/headphones.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.playList.libraryName,
                      style: GoogleFonts.lato(
                        fontSize: 25,
                        color:
                            (UserInfo.isDark
                                ? darkTheme.primaryColor
                                : lightTheme.primaryColor),

                        decoration: TextDecoration.none,
                      ),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.sharePlayList = SharePlayList(
                                finalize: () {
                                  widget.sharePlayList = null;
                                },
                                playListName: widget.playList.libraryName,
                              );
                            });
                          },
                          child: Icon(
                            Icons.ios_share,
                            color:
                                UserInfo.isDark
                                    ? darkTheme.primaryColor
                                    : const Color.fromRGBO(11, 2, 175, 1),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.filter_list_alt,
                            color:
                                UserInfo.isDark
                                    ? darkTheme.primaryColor
                                    : const Color.fromRGBO(11, 2, 175, 1),
                          ),
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                          child: Image.asset(
                            "assets/icons/shuffle.png",
                            width: 23,
                            height: 23,

                            color:
                                UserInfo.isDark
                                    ? darkTheme.primaryColor
                                    : const Color.fromRGBO(11, 2, 175, 1),
                          ),
                        ),

                        SizedBox(width: 4),
                        GestureDetector(
                          child: Icon(
                            Icons.favorite_outline_outlined,
                            color:
                                UserInfo.isDark
                                    ? darkTheme.primaryColor
                                    : const Color.fromRGBO(11, 2, 175, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                height: deviceHeight - 500,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...widget.playList.content.map((music) {
                        return PlaylistMusicBar(music: music);
                      }),
                    ],
                  ),
                ),
              ),

              // PlaylistMusicBar(music: Music(name: "yoohoo", singer: "yoohoo")),
            ],
          ),
          Column(
            children: [
              SizedBox(height: deviceHeight - 100),

              CachedMusicBar(changeToFullScreen: widget.changeToMusicScreen),
            ],
          ),
          if (widget.sharePlayList != null) widget.sharePlayList!,
        ],
      ),
    );
  }
}
