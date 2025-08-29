import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/cached_music_player.dart';
import 'package:login/main.dart';
import 'package:login/music.dart';

class PlaylistMusicBar extends StatefulWidget {
  final Music music;
  PlaylistMusicBar({required this.music, super.key});
  @override
  State<PlaylistMusicBar> createState() {
    return _PlaylistMusicBarState();
  }
}

class _PlaylistMusicBarState extends State<PlaylistMusicBar> {
  bool playing = false;
  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
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
                                  widget.music.name!,
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  widget.music.singer!,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                          ],
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Cache status indicator
                            const SizedBox(width: 18),
                            // Play/Pause button
                            GestureDetector(
                              onTap: () async {
                                playing = !playing;
                                final String? url = widget.music.URL;
                                if (url == null || url.isEmpty) {
                                  return;
                                }
                                try {
                                  // Set the current music URL so other widgets (e.g., music bar) can display it
                                  UserInfo.currentMusicUrl = url;

                                  // Trigger play/pause for this track
                                  await CachedMusicPlayer().togglePlayPause(
                                    musicName: url,
                                    onDone: () {
                                      if (mounted) setState(() {});
                                    },
                                    onError: (error) {
                                      if (mounted) setState(() {});
                                    },
                                  );
                                } catch (_) {
                                  if (mounted) setState(() {});
                                }
                              },
                              child: Icon(
                                (!playing == true
                                    ? Icons.play_circle
                                    : Icons.pause_circle),
                              ),
                              // child: ValueListenableBuilder(
                              //   valueListenable: CachedMusicPlayer.isPlaying,
                              //   builder: (cntx, val, _) {
                              //     return Icon(
                              //       val
                              //           ? Icons.pause_circle
                              //           : Icons.play_circle,
                              //       size: 35,
                              //       color: Colors.white,
                              //     );
                              //   },
                              // ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 0.8),
      ],
    );
  }
}
