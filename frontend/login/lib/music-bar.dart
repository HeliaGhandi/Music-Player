import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/cached_music_player.dart';
import 'dart:async'; // Added for StreamSubscription
import 'package:just_audio/just_audio.dart'; // Added for PlayerState

/// Enhanced music bar with caching support
class CachedMusicBar extends StatefulWidget {
  void Function() changeToFullScreen;
  CachedMusicBar({super.key, required this.changeToFullScreen});

  @override
  State<CachedMusicBar> createState() {
    return _CachedMusicBarState();
  }
}

class _CachedMusicBarState extends State<CachedMusicBar> {
  final CachedMusicPlayer _musicPlayer = CachedMusicPlayer();

  // Stream subscription for player state updates
  StreamSubscription<PlayerState>? _playerStateSubscription;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    // Listen to player state changes
    _playerStateSubscription = _musicPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          // State is managed by the music player now
        });
      }
    });

    // Listen to position updates
    _progressTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (mounted && CachedMusicPlayer.isPlaying.value) {
        setState(() {
          // Progress is calculated in the build method now
        });
      }
    });
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _progressTimer?.cancel();
    _musicPlayer.stop();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    try {
      print("=== STARTING MUSIC REQUEST ===");
      print(
        "Current music state - isPlaying: ${CachedMusicPlayer.isPlaying.value}",
      );

      const musicName = "to_kharab_kardi_golzar.mp3";
      print("About to call _musicPlayer.togglePlayPause for: $musicName");

      await _musicPlayer.togglePlayPause(
        musicName: musicName,
        onDone: () {
          print("=== SONG FINISHED ===");
          if (mounted) {
            setState(() {
              // State is managed by the music player now
            });
          }
          print("Song finished");
        },
        onError: (err) {
          print("=== STREAMING ERROR ===");
          print("Error details: $err");
          if (mounted) {
            setState(() {
              // State is managed by the music player now
            });
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

  double _getProgress() {
    final position = _musicPlayer.position;
    final duration = _musicPlayer.duration;
    if (position != null && duration != null && duration.inMilliseconds > 0) {
      return position.inMilliseconds / duration.inMilliseconds;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: widget.changeToFullScreen,
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              child: SizedBox(height: 80, width: deviceWidth),
              decoration: BoxDecoration(
                color: Color(0xFFE57BA1),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 20),
                    Container(
                      width: 60,
                      height: 60,
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
                        const SizedBox(width: 8),
                        // Play/Pause button
                        GestureDetector(
                          onTap: () {
                            _togglePlayPause();
                            CachedMusicPlayer.togglePlayingState();
                          },
                          child: ValueListenableBuilder(
                            valueListenable: CachedMusicPlayer.isPlaying,
                            builder: (cntx, val, _) {
                              return Icon(
                                val ? Icons.pause_circle : Icons.play_circle,
                                size: 40,
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
            Column(
              children: [
                SizedBox(height: deviceHeight - 850),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: LinearProgressIndicator(
                    value: _getProgress(),
                    backgroundColor: Colors.white24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
