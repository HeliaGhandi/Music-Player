import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/cached_music_player.dart';
import 'dart:async'; // Added for StreamSubscription
import 'package:just_audio/just_audio.dart';
import 'package:login/main.dart';
import 'package:login/content-display.dart';
import 'dart:math';

class PlaylistMusicBar extends StatefulWidget {
  @override
  State<PlaylistMusicBar> createState() {
    return _PlaylistMusicBarState();
  }
}

class _PlaylistMusicBarState extends State<PlaylistMusicBar> {
  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: SizedBox(height: 60, width: deviceWidth),
            decoration: BoxDecoration(
              color:
                  UserInfo.isDark
                      ? const Color.fromRGBO(198, 174, 245, 1)
                      : const Color.fromARGB(255, 69, 39, 102),
              //Color(0xFFE57BA1),
              //borderRadius: BorderRadius.circular(15),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 20),
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(3),
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
                        "Name",
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "Singer",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                  SizedBox(width: deviceWidth - 200),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Cache status indicator
                      const SizedBox(width: 18),
                      // Play/Pause button
                      GestureDetector(
                        onTap: () {
                          //  _togglePlayPause();
                          CachedMusicPlayer.togglePlayingState();
                        },
                        child: ValueListenableBuilder(
                          valueListenable: CachedMusicPlayer.isPlaying,
                          builder: (cntx, val, _) {
                            return Icon(
                              val ? Icons.pause_circle : Icons.play_circle,
                              size: 35,
                              color: Colors.white,
                            );
                          },
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
    );
  }
}
