import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notif extends StatelessWidget {
  String text;
  Color color = Colors.white;
  Notif({required this.text, Color? color, super.key}) {
    if (color != null) this.color = color;
  }
  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight =
        MediaQuery.of(
          context,
        ).size.height;

    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          SizedBox(height: 55),
          Container(
            width: deviceWidth - 120,
            height: 70,
            alignment:
                Alignment
                    .center, // This centers the child (Text) within the Container both horizontally and vertically
            child: Text(
              text,
              style: GoogleFonts.lato(fontSize: 16),
              textAlign:
                  TextAlign
                      .center, // This ensures the text itself is centered if it wraps or has multiple lines
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
