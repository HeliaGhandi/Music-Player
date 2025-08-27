import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/recents-musics-button.dart';
import 'package:login/made-for-you-musics-button.dart';
import 'package:login/scrollable-section.dart';
import 'package:login/navigation-bar.dart';
import 'package:login/music-bar.dart';
import 'package:login/content-display.dart';
import 'package:login/main.dart';
import 'package:login/musics.dart';
import 'package:file_picker/file_picker.dart';
import 'package:login/cached_music_player.dart';

class HomeScreen extends StatefulWidget {
  void Function() changeToBrowse;
  void Function() changeToHome;
  void Function() changeToMusicScreen;
  void Function() changeToSettingScreen;
  void Function() changeToLibrary;
  void Function() changeToDirect;
  late bool? isDark;
  HomeScreen({
    this.isDark,
    required this.changeToDirect,
    required this.changeToLibrary,
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
            decoration: BoxDecoration(
              color:
                  (UserInfo.isDark ?? true
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
                  GestureDetector(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage(UserInfo.profilePictureURL),
                        ),
                      ),
                    ),
                    onTap: () {
                      widget.changeToSettingScreen();
                    },
                  ),
                  SizedBox(width: deviceWidth - 120),

                  GestureDetector(
                    child: Image.asset(
                      "assets/icons/icon.png",
                      color:
                          (UserInfo.isDark ?? true
                              ? darkTheme.primaryColor
                              : lightTheme.primaryColor),
                      width: 35,
                    ),
                    onTap: () {
                      widget.changeToDirect();
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                height: deviceHeight - 320,
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
                              color:
                                  (UserInfo.isDark ?? true
                                      ? darkTheme.focusColor
                                      : lightTheme.focusColor),
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
                            isDark: UserInfo.isDark ?? true,
                            size: 100,
                            name: "AM",
                            cover: "assets/covers/am.jpg",
                          ),
                          SizedBox(width: 25),
                          RecentsMusicsButton(
                            isDark: UserInfo.isDark ?? true,
                            size: 100,
                            name: "EBI",
                            cover: "assets/covers/ebi.jpg",
                          ),
                          SizedBox(width: 25),
                          RecentsMusicsButton(
                            isDark: UserInfo.isDark ?? true,
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
                            isDark: UserInfo.isDark ?? true,
                            size: 100,
                            name: "EILISH",
                            cover: "assets/covers/billie.jpg",
                          ),
                          SizedBox(width: 25),
                          RecentsMusicsButton(
                            isDark: UserInfo.isDark ?? true,
                            size: 100,
                            name: "HIRA",
                            cover: "assets/covers/shayea.jpeg",
                          ),
                          SizedBox(width: 25),
                          RecentsMusicsButton(
                            isDark: UserInfo.isDark ?? true,
                            size: 100,
                            name: "heli",
                            cover: "assets/covers/heliyom.jpg",
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      ScrollableSection(
                        topic: "Liked Songs",
                        size: 100,
                        space: 20,
                        content: [
                          for (int i = 0; i < Musics.likedSongs.length; i++)
                            MadeForYouMusicsButton(
                              size: 100,
                              space: 20,
                              name:
                                  Musics.likedSongs[i].name ??
                                  "YOU HAVENT LIKED ANY MUSIC YET",
                              url:
                                  Musics.likedSongs[i].URL ??
                                  "YOU HAVENT LIKED ANY MUSIC YET",
                              cover: "assets/covers/questions-mark.png",
                            ),
                        ],
                      ),
                      SizedBox(height: 30),
                      ScrollableSection(
                        content: [
                          for (int i = 0; i < Musics.sharedSongs.length; i++)
                            MadeForYouMusicsButton(
                              size: 100,
                              space: 20,
                              name:
                                  Musics.sharedSongs[i].name ??
                                  "No one likes youuuu, go cry",
                              url:
                                  Musics.sharedSongs[i].URL ??
                                  "No one likes youuuu, go cry",
                              cover: "assets/covers/questions-mark.png",
                            ),
                        ],
                        topic: "Shared With You",
                        size: 150,
                        space: 25,
                      ),
                      SizedBox(height: 30),
                      ScrollableSection(
                        topic: "All Server Musics",
                        size: 100,
                        space: 0,
                        content: [
                          for (int i = 0; i < Musics.musics.length; i++)
                            MadeForYouMusicsButton(
                              size: 100,
                              space: 20,
                              name: Musics.musics[i].name ?? "yoohoo",
                              url: Musics.musics[i].URL ?? "yoohoo",
                            ),
                        ],
                      ),
                      SizedBox(height: 30),
                      // New: All Device Musics section with + button
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Text(
                            "All Device Musics",
                            style: GoogleFonts.lato(
                              color:
                                  (UserInfo.isDark ?? true
                                      ? darkTheme.focusColor
                                      : lightTheme.focusColor),
                              decoration: TextDecoration.none,
                              fontSize: 24,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline, size: 28),
                            color:
                                (UserInfo.isDark ?? true
                                    ? darkTheme.focusColor
                                    : lightTheme.focusColor),
                            onPressed: () async {
                              final result = await FilePicker.platform
                                  .pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      "mp3",
                                      "wav",
                                      "m4a",
                                      "aac",
                                      "flac",
                                    ],
                                  );
                              if (result != null &&
                                  result.files.single.path != null) {
                                final path = result.files.single.path!;
                                // Play local file
                                await CachedMusicPlayer().playLocalFile(path);
                              }
                            },
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                      SizedBox(height: 12),
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
                changeToLibrary: widget.changeToLibrary,
                changeToBrowse: widget.changeToBrowse,
                changeToHome: widget.changeToHome,
                //
              ),
            ],
          ),
        ],
      ),
    );
  }
}
