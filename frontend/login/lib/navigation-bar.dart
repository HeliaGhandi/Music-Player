import 'package:flutter/material.dart';

class NavigationBari extends StatefulWidget {
  int select;
  void Function() changeToBrowse;
  void Function() changeToHome;
  void Function() changeToLibrary;
  NavigationBari({
    required this.changeToLibrary,
    required this.select,
    required this.changeToHome,
    super.key,
    required this.changeToBrowse,
  });
  @override
  State<NavigationBari> createState() {
    return _NavigationBariState();
  }
}

class _NavigationBariState extends State<NavigationBari> {
  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: SizedBox(height: 80, width: deviceWidth),

            decoration: BoxDecoration(color: Color.fromRGBO(85, 85, 85, 0.627)),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 18),
              IconButton(
                onPressed: widget.changeToHome,
                icon: Icon(
                  Icons.home_outlined,
                  color:
                      (widget.select == 1) ? Color(0xFFA4D5FF) : Colors.white,
                  size: 35,
                ),
              ),
              SizedBox(width: 100),
              IconButton(
                onPressed: widget.changeToBrowse,
                icon: Icon(
                  Icons.search,
                  color:
                      (widget.select == 2) ? Color(0xFFA4D5FF) : Colors.white,

                  size: 35,
                ),
              ),
              SizedBox(width: 100),
              IconButton(
                onPressed: () {
                  widget.changeToLibrary();
                },
                icon: Icon(
                  Icons.library_music_outlined,
                  color:
                      (widget.select == 3) ? Color(0xFFA4D5FF) : Colors.white,
                  size: 35,
                ),
              ),
              SizedBox(width: 18),
            ],
          ),
        ],
      ),
    );
  }
}
