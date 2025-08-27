import 'dart:ui';
import 'package:flutter/material.dart';

class IOSKeyboard extends StatefulWidget {
  final void Function(String) onKeyTap;
  final VoidCallback onBackspace;
  final VoidCallback onClose;
  final VoidCallback onReturn;

  const IOSKeyboard({
    required this.onKeyTap,
    required this.onBackspace,
    required this.onClose,
    required this.onReturn,
    Key? key,
  }) : super(key: key);

  @override
  State<IOSKeyboard> createState() => _IOSKeyboardState();
}

class _IOSKeyboardState extends State<IOSKeyboard> {
  bool _isUppercase = false;
  bool _isSymbolMode = false;

  final List<String> lettersRow1 = [
    "Q",
    "W",
    "E",
    "R",
    "T",
    "Y",
    "U",
    "I",
    "O",
    "P",
  ];
  final List<String> lettersRow2 = [
    "A",
    "S",
    "D",
    "F",
    "G",
    "H",
    "J",
    "K",
    "L",
  ];
  final List<String> lettersRow3 = ["Z", "X", "C", "V", "B", "N", "M"];

  // These are the two different layouts for the symbols/numbers view
  final List<String> symbols1 = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
  ];
  final List<String> symbols2 = [
    "-",
    "/",
    ":",
    ";",
    "(",
    ")",
    "\$",
    "&",
    "@",
    "\"",
  ];
  final List<String> symbols3 = [".", ",", "?", "!", "'"];

  Widget _buildKey(String label, {double flex = 1, bool isSpecial = false}) {
    String displayLabel =
        _isUppercase && !isSpecial ? label.toUpperCase() : label.toLowerCase();

    // The number/symbol keys don't change case with the shift key
    if (_isSymbolMode) {
      displayLabel = label;
    } else {
      displayLabel = _isUppercase ? label.toUpperCase() : label.toLowerCase();
    }

    Color keyColor =
        isSpecial
            ? Colors.white.withOpacity(0.2)
            : Colors.white.withOpacity(0.4);

    return Expanded(
      flex: flex.toInt(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: GestureDetector(
          onTap: () => widget.onKeyTap(displayLabel),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: keyColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    displayLabel,
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
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Letters rows
              if (!_isSymbolMode) ...[
                Row(children: lettersRow1.map((k) => _buildKey(k)).toList()),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10), // Indent for the second row
                    ...lettersRow2.map((k) => _buildKey(k)).toList(),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildSpecialKey(
                      Icon(
                        Icons.arrow_upward,
                        color: _isUppercase ? Colors.blue : Colors.white,
                      ),
                      () => setState(() => _isUppercase = !_isUppercase),
                      flex: 2,
                    ),
                    ...lettersRow3.map((k) => _buildKey(k)).toList(),
                    _buildSpecialKey(
                      const Icon(
                        Icons.backspace_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                      widget.onBackspace,
                      flex: 2,
                    ),
                  ],
                ),
              ] else ...[
                // Symbol rows
                Row(
                  children:
                      symbols1
                          .map((k) => _buildKey(k, isSpecial: true))
                          .toList(),
                ),
                const SizedBox(height: 4),
                Row(
                  children:
                      symbols2
                          .map((k) => _buildKey(k, isSpecial: true))
                          .toList(),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildSpecialKey(
                      const Text("ABC", style: TextStyle(color: Colors.white)),
                      () => setState(() => _isSymbolMode = !_isSymbolMode),
                      flex: 2,
                    ),
                    ...symbols3
                        .map((k) => _buildKey(k, isSpecial: true))
                        .toList(),
                    _buildSpecialKey(
                      const Icon(
                        Icons.backspace_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                      widget.onBackspace,
                      flex: 2,
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 4),

              // Bottom row: symbol/number switcher, space, return
              Row(
                children: [
                  _buildSpecialKey(
                    const Text(
                      "123",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    () => setState(() => _isSymbolMode = !_isSymbolMode),
                    flex: 2,
                  ),
                  _buildSpecialKey(
                    const Text(
                      " ",
                      style: TextStyle(fontSize: 1),
                    ), // Invisible text for spacing
                    () => widget.onKeyTap(" "),
                    flex: 6,
                    color: Colors.white.withOpacity(0.4),
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
