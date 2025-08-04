import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicBar extends StatefulWidget {
  void Function() changeToFullScreen;
  MusicBar({super.key, required this.changeToFullScreen});
  @override
  State<MusicBar> createState() {
    return _MusicBarState();
  }
}

class _MusicBarState extends State<MusicBar> {
  final musicState = MusicState();
  @override
  Widget build(BuildContext context) {
    double progress = 0.9;
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
                      //mainAxisSize: MainAxisSize.min,
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
                      ],
                    ),
                    SizedBox(width: deviceWidth - 200),
                    (musicState.isPlaying == true)
                        ? GestureDetector(
                          onTap: () {
                            setState(() {
                              musicState.isPlaying = false;
                            });
                          },
                          child: Icon(Icons.pause_circle, size: 40),
                        )
                        : GestureDetector(
                          onTap: () {
                            setState(() {
                              musicState.isPlaying = true;
                            });
                          },
                          child: Icon(Icons.play_circle, size: 40),
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
                  child: LinearProgressIndicator(value: progress),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MusicState {
  static final MusicState _instance = MusicState._internal();
  bool isPlaying = false; // default

  MusicState._internal();

  factory MusicState() {
    return _instance;
  }
}
