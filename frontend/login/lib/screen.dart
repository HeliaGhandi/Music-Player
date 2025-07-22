import 'package:flutter/material.dart';
import 'authentication-screens-handler.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() {
    return _ScreenState();
  }
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return AuthenticationScreenHandler();
  }
}
