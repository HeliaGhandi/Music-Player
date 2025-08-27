import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/main.dart';
import 'package:login/content-display.dart';
import 'package:login/cached_music_player.dart';

class MadeForYouMusicsButton extends StatelessWidget {
  double size;
  String name;
  String? cover;
  double space;
  String? url; // music url like "to-kharab-kardi!golzar.mp3"
  MadeForYouMusicsButton({
    required this.size,
    required this.space,
    super.key,
    required this.name,
    this.cover,
    this.url,
  });
  //
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: Column(
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 0.7),
                  color: Colors.green,
                  image:
                      cover != null
                          ? DecorationImage(
                            image: AssetImage(cover!),
                            fit: BoxFit.cover,
                          )
                          : null,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 100,

                child: Text(
                  textAlign: TextAlign.center,
                  (name.length < 18 ? name + "\n" : name),
                  style: GoogleFonts.poppins(
                    color:
                        (UserInfo.isDark
                            ? darkTheme.focusColor
                            : lightTheme.focusColor),
                    fontSize: 10.5,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
          onTap: () async {
            // If a specific url is provided, use it; fallback to name if you encode elsewhere
            final String selectedUrl = url ?? name;
            // Update global current URL so the bottom bar shows correct song
            UserInfo.currentMusicUrl = selectedUrl;

            // Start or toggle playback using the cached player
            final player = CachedMusicPlayer();
            await player.togglePlayPause(
              musicName: selectedUrl,
              onDone: () {},
              onError: (e) {},
            );
          },
        ),
        SizedBox(width: space),
      ],
    );
  }
}
