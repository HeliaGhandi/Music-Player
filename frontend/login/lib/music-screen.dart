import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:login/music-bar.dart';
import 'package:login/cached_music_player.dart';
import 'package:login/share.dart';
import 'package:login/main.dart';
import 'package:login/json-handler.dart';
import 'package:login/musics.dart';
import 'package:login/music.dart';

class MusicScreen extends StatefulWidget {
  String name;
  String? cover;
  String singer;
  void Function() changeToHomeScreen;
  Share? share;
  //time ;

  MusicScreen({
    required this.changeToHomeScreen,
    required this.name,
    required this.singer,

    this.cover,
    super.key,
  });

  @override
  State<MusicScreen> createState() {
    return _MusicScreenState();
  }
}

class _MusicScreenState extends State<MusicScreen> {
  final CachedMusicPlayer _musicPlayer = CachedMusicPlayer();

  double _getProgress() {
    final position = _musicPlayer.position;
    final duration = _musicPlayer.duration;
    if (position != null && duration != null && duration.inMilliseconds > 0) {
      return position.inMilliseconds / duration.inMilliseconds;
    }
    return 0.0;
  }

  Future<void> _togglePlayPause() async {
    try {
      print("=== STARTING MUSIC REQUEST ===");
      print(
        "Current music state - isPlaying: ${CachedMusicPlayer.isPlaying.value}",
      );

      String musicName = UserInfo.currentMusicUrl;
      await _musicPlayer.togglePlayPause(
        musicName: musicName,
        onDone: () {
          print("=== SONG FINISHED ===");
          if (mounted) {
            setState(() {});
          }
          print("Song finished");
        },
        onError: (err) {
          print("=== STREAMING ERROR ===");
          print("Error details: $err");
          if (mounted) {
            setState(() {});
          }
          print("Streaming error: $err");
        },
      );

      print("=== MUSIC REQUEST COMPLETED ===");
    } catch (e) {
      print("=== ERROR IN _togglePlayPause ===");
      print("Exception: $e");
      print("Stack trace: ${StackTrace.current}");
      setState(() {
        // State is managed by the music player now
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Keep title/artist in sync with the bar by parsing UserInfo.currentMusicUrl
    String raw = UserInfo.currentMusicUrl;
    String displayName = widget.name;
    String displayArtist = widget.singer;
    try {
      final parts = raw.split('!');
      if (parts.length >= 2) {
        displayName = parts[0].replaceAll('-', ' ').trim();
        displayArtist =
            parts[1].replaceAll('.mp3', '').replaceAll('-', ' ').trim();
      }
    } catch (_) {}

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 0) {
          print("Dragged down!");
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFD2EAFF),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 50),
                Transform.rotate(
                  angle: 3 * pi / 2,
                  child: GestureDetector(
                    child: Icon(Icons.arrow_back_ios_new, size: 40),
                    onTap: () async {
                      await Musics.loadMusicsFromServer();
                      Musics.extractInfoFromJson();
                      widget.changeToHomeScreen();
                    },
                  ),
                ),
                SizedBox(height: 80),
                Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 0.7),
                    color: Colors.green,
                    image:
                        widget.cover != null
                            ? DecorationImage(
                              image: AssetImage(widget.cover!),
                              fit: BoxFit.cover,
                            )
                            : null,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 35),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: Text(
                            displayName,
                            style: GoogleFonts.lato(fontSize: 35),
                          ),
                        ), //color: Colors(0xFF555555),),),
                        Text(
                          displayArtist,
                          style: GoogleFonts.lato(fontSize: 25),
                        ),
                      ],
                    ),
                    SizedBox(width: 110),
                    GestureDetector(
                      onTap: () async {
                        // Backend toggles like/dislike internally; always send LIKE_MUSIC
                        final Map<String, String> request = {
                          "command": "like_music",
                          "username": UserInfo.username,
                          "musicUrl": UserInfo.currentMusicUrl,
                        };

                        final Map<String, dynamic> response =
                            await JsonHandler(json: request).sendTestRequest();
                        print('Server Response: $response');

                        if (response['success'] == true) {
                          await Musics.loadLikedMusicsFromServer();
                          Musics.extractInfoFromLikedJson();
                          setState(() {});
                        } else {
                          await Musics.loadLikedMusicsFromServer();
                          Musics.extractInfoFromLikedJson();
                          setState(() {});
                        }
                      },
                      child:
                          (Musics.likedMusicNames.contains(widget.name)
                              ? Icon(
                                Icons.favorite_outline_outlined,
                                size: 30,
                                color: Colors.red,
                              )
                              : Icon(
                                Icons.favorite_outline_outlined,
                                size: 30,
                              )),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.add_circle_outline_sharp, size: 30),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: LinearProgressIndicator(value: _getProgress()),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.share = Share(
                              finalize: () {
                                setState(() {
                                  widget.share = null;
                                });
                              },
                            );
                          });
                        },
                        child: Icon(Icons.ios_share_outlined, size: 30),
                      ),
                      SizedBox(width: 35),
                      Icon(Icons.skip_previous_outlined, size: 45),
                      SizedBox(width: 20),
                      GestureDetector(
                        child: ValueListenableBuilder(
                          valueListenable: CachedMusicPlayer.isPlaying,
                          builder: (cntx, val, _) {
                            return Icon(
                              val ? Icons.pause_circle : Icons.play_circle,
                              size: 40,
                              color: Colors.black,
                            );
                          },
                        ),

                        onTap: () {
                          _togglePlayPause();
                          setState(() {
                            CachedMusicPlayer.togglePlayingState();
                          });
                        },
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.skip_next_outlined, size: 45),
                      SizedBox(width: 35),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          "assets/icons/repeat.png",
                          width: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.share != null) widget.share!,
          ],
        ),
      ),
    );
  }
}
