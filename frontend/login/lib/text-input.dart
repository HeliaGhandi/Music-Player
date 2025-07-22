import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  String text;
  double border;
  Color color;
  TextInput({super.key, required this.text, required this.border, required this.color});
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: text);

    // Move cursor to position 3 (e.g., after "Hel")
    controller.selection = TextSelection.fromPosition(TextPosition(offset: 2));
    return TextField(
      controller: controller,

      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: color,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(border)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(border),
        ),
      ),
    );
  }
}
