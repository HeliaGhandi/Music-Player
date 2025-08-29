import 'dart:async'; // Import the dart:async library
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notif extends StatefulWidget {
  final String text;
  final Color color;
  Color? proceedColor;
  void Function() finalize;
  void Function()? onProceed;

  bool? doesHaveButton;
  Notif({
    required this.text,
    Color? color,
    required this.finalize,
    this.doesHaveButton,
this.proceedColor,
    this.onProceed,
    super.key,
  }) : color = color ?? Colors.white;

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 7), () {
      if (mounted) {
        setState(() {
          _isVisible = false;
        });
        widget.finalize();
      }
    });
  }

  @override
  void dispose() {
    // You should also cancel the timer here if it's still active.
    // For this simple example, we'll assume the timer will always complete.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink(); // Return an empty widget if not visible
    }

    double? deviceWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const SizedBox(height: 55),
          Container(
            width: deviceWidth - 110,
            height: 70,
            alignment: Alignment.center,
            child: Text(
              widget.text,
              style: GoogleFonts.lato(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          if (widget.doesHaveButton != null && widget.doesHaveButton!)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = false;
                    });
                    widget.finalize();
                  },
                  child: Text("CANCEL"),

                  style: OutlinedButton.styleFrom(
                    backgroundColor: widget.color,
                    fixedSize: Size(deviceWidth / 2 - 65, 30),
                  ),
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      widget.onProceed!();
                    });
                  },
                  child: Text("PROCEED"),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: widget.color,
                    foregroundColor: widget.proceedColor ?? Colors.deepPurple,
                    fixedSize: Size(deviceWidth / 2 - 65, 30),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
