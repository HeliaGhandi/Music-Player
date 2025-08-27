import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/content-display.dart';

class RecentsMusicsButton extends StatelessWidget {
  double size;
  String name;
  String? cover;
  bool isDark;
  RecentsMusicsButton({
    required this.isDark,
    required this.size,
    super.key,
    required this.name,
    this.cover,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: GoogleFonts.poppins(
              color: (isDark ? darkTheme.focusColor : lightTheme.focusColor),
              fontSize: 10.5,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
