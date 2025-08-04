import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicScreen extends StatefulWidget {
  String name;
  String? cover;
  String singer;
  //time ;

  MusicScreen({
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
  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 130),
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
                        Text(
                          widget.name,
                          style: GoogleFonts.lato(fontSize: 35),
                        ), //color: Colors(0xFF555555),),),
                        Text(
                          widget.singer,
                          style: GoogleFonts.lato(fontSize: 25),
                        ),
                      ],
                    ),
                    SizedBox(width: 110),
                    Icon(Icons.favorite_outline_outlined, size: 30),
                    SizedBox(width: 5),
                    Icon(Icons.add_circle_outline_sharp, size: 30),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: LinearProgressIndicator(value: 0.4),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.ios_share_outlined, size: 30),
                      SizedBox(width: 35),
                      Icon(Icons.skip_previous_outlined, size: 45),
                      SizedBox(width: 20),
                      Icon(Icons.play_circle_fill_outlined, size: 50),
                      SizedBox(width: 20),
                      Icon(Icons.skip_next_outlined, size: 45),
                      SizedBox(width: 35),
                      Icon(Icons.repeat, size: 30),
                    ],
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
