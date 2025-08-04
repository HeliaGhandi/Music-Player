import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MadeForYouMusicsButton extends StatelessWidget {
  double size;
  String name;
  String? cover;
  MadeForYouMusicsButton({
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
            ),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: GoogleFonts.poppins(
              color: Colors.white,
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
