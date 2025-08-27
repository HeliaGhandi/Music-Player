import 'dart:ui';
import 'package:flutter/material.dart';

class IOSNumpad extends StatefulWidget {
  final void Function(String) onKeyTap;
  final VoidCallback onBackspace;
  final VoidCallback onClose;
  final VoidCallback onReturn;
  const IOSNumpad({
    required this.onKeyTap,
    required this.onBackspace,
    required this.onClose,
    required this.onReturn,
    Key? key,
  }) : super(key: key);

  @override
  State<IOSNumpad> createState() => _IOSNumpadState();
}

class _IOSNumpadState extends State<IOSNumpad> {
  bool _isUppercase = false;

  Widget _buildKey(String label, {double flex = 1, Color? color}) {
    return Expanded(
      flex: flex.toInt(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: GestureDetector(
          onTap:
              () => widget.onKeyTap(_isUppercase ? label : label.toLowerCase()),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: color ?? Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    _isUppercase ? label : label.toLowerCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialKey(
    Widget child,
    VoidCallback onTap, {
    double flex = 1,
    Color? color,
  }) {
    return Expanded(
      flex: flex.toInt(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: color ?? Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> row1 = ["1", "2", "3"];
    List<String> row2 = ["4", "5", "6"];
    List<String> row3 = ["7", "8", "9"];

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: row1.map((k) => _buildKey(k)).toList()),
              Row(children: row2.map((k) => _buildKey(k)).toList()),
              Row(children: row3.map((k) => _buildKey(k)).toList()),
              Row(
                children: [
                  _buildKey(".", flex: 1), // Example for a decimal point
                  _buildKey("0", flex: 1),
                  _buildSpecialKey(
                    const Icon(
                      Icons.backspace_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                    widget.onBackspace,
                  ),
                ],
              ),
              Row(
                children: [
                  _buildSpecialKey(
                    Icon(Icons.keyboard_hide, size: 20, color: Colors.white),
                    widget.onClose,
                  ),
                  _buildSpecialKey(
                    const Text(
                      "Return",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    widget.onReturn,
                    flex: 2,
                    color: Colors.blue.withOpacity(0.6),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
