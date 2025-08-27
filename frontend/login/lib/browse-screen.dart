import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/main.dart';
import 'package:login/navigation-bar.dart';
import 'package:login/music-bar.dart';
import 'package:login/content-display.dart';
import 'package:login/ios-keyboard.dart';

class BrowseScreen extends StatefulWidget {
  void Function() changeToHome;
  void Function() changeToBrowse;
  void Function() changeToMusic;
  void Function() changeToLibrary;
  bool? isDark;
  BrowseScreen({
    this.isDark,
    required this.changeToLibrary,
    required this.changeToHome,
    required this.changeToBrowse,
    required this.changeToMusic,
  });
  double space = 25;
  State<BrowseScreen> createState() {
    return _BrowseScreenWidget();
  }
}

class _BrowseScreenWidget extends State<BrowseScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  bool _showCustomKeyboard = false;

  TextEditingController? _activeController;

  void _onKeyTap(String value) {
    _searchController.text += value;
  }

  void _onBackspace() {
    if (_activeController != null && _activeController!.text.isNotEmpty) {
      _activeController!.text = _activeController!.text.substring(
        0,
        _activeController!.text.length - 1,
      );
    }
  }

  void _onReturn() {
    setState(() {
      _showCustomKeyboard = false;
      _activeController = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double madeForYouSpace = 20;
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: deviceWidth,
              height: deviceHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    (UserInfo.isDark ?? true
                        ? darkTheme.scaffoldBackgroundColor
                        : lightTheme.scaffoldBackgroundColor),
              ),
            ),

            Column(
              children: [
                SizedBox(height: 55),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Search",
                      style: GoogleFonts.lato(
                        fontSize: 35,
                        color:
                            (UserInfo.isDark ?? true
                                ? darkTheme.primaryColor
                                : lightTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: _searchController,
                    onTap: () {
                      setState(() {
                        _showCustomKeyboard = true;
                        _activeController = _searchController;
                      });
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 10),
                          Image.asset("assets/icons/search.png", width: 40),
                          SizedBox(width: 10),
                        ],
                      ),
                      //ofset ba sized box easy !
                      hintText: "What do you want to listen to?",

                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Browse all",
                      style: GoogleFonts.poppins(
                        color:
                            (UserInfo.isDark ?? true
                                ? darkTheme.primaryColor
                                : lightTheme.primaryColor),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: deviceHeight + 190,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BrowseCategory(
                                name: "Musics",
                                color: Colors.pink,
                              ),
                              SizedBox(width: 20),
                              BrowseCategory(
                                name: "Podcasts",
                                color: Colors.lightBlue,
                              ),
                            ],
                          ),
                          SizedBox(height: widget.space),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BrowseCategory(
                                name: "Made For You",
                                color: Colors.green,
                              ),
                              SizedBox(width: 20),
                              BrowseCategory(
                                name: "New Released",
                                color: const Color.fromARGB(86, 255, 230, 0),
                              ),
                            ],
                          ),
                          SizedBox(height: widget.space),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BrowseCategory(
                                name: "Latest",
                                color: Colors.pink,
                              ),
                              SizedBox(width: 20),
                              BrowseCategory(
                                name: "On Fire",
                                color: Colors.purple,
                              ),
                            ],
                          ),
                          SizedBox(height: widget.space),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BrowseCategory(
                                name: "Liked By Friends",
                                color: const Color.fromARGB(109, 255, 255, 1),
                              ),
                              SizedBox(width: 20),
                              BrowseCategory(name: "Trend", color: Colors.red),
                            ],
                          ),
                          SizedBox(height: widget.space),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BrowseCategory(
                                name: "Liked By You",
                                color: Colors.brown,
                              ),
                              SizedBox(width: 20),
                              BrowseCategory(
                                name: "yoohoo",
                                color: Colors.teal,
                              ),
                            ],
                          ),
                          SizedBox(height: widget.space),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BrowseCategory(
                                name: "yoohoo",
                                color: Colors.deepOrange,
                              ),
                              SizedBox(width: 20),
                              BrowseCategory(
                                name: "yoohoo",
                                color: Colors.indigo,
                              ),
                            ],
                          ),
                          SizedBox(height: widget.space),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BrowseCategory(
                                name: "yoohoo",
                                color: Colors.amber,
                              ),
                              SizedBox(width: 20),
                              BrowseCategory(
                                name: "yoohoo",
                                color: Colors.lime,
                              ),
                            ],
                          ),
                          SizedBox(height: widget.space),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 14.5),
                SizedBox(height: deviceHeight - 180),
                // Use CachedMusicBar for enhanced music playback with caching
                CachedMusicBar(changeToFullScreen: widget.changeToMusic),
                // Or use the original MusicBar for JSON-based streaming:
                // MusicBar(changeToFullScreen: widget.changeToMusic,),
                SizedBox(height: 5),
                NavigationBari(
                  select: 2,
                  changeToLibrary: widget.changeToLibrary,
                  changeToBrowse: widget.changeToBrowse,
                  changeToHome: widget.changeToHome,
                ),
              ],
            ),
            if (_showCustomKeyboard)
              Align(
                alignment: Alignment.bottomCenter,
                child: IOSKeyboard(
                  onKeyTap: _onKeyTap,
                  onBackspace: _onBackspace,
                  onClose: () => setState(() => _showCustomKeyboard = false),
                  onReturn: _onReturn,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BrowseCategory extends StatelessWidget {
  double? size;
  String? name;
  String? cover;
  Color? color;
  BrowseCategory({this.size, super.key, this.name, this.cover, this.color});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            width: 175,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(color: Colors.grey.shade400, width: 0.7),
              color: color ?? Colors.green,
              image:
                  cover != null
                      ? DecorationImage(
                        image: AssetImage(cover!),
                        fit: BoxFit.cover,
                      )
                      : null,
            ),
          ),
          Column(
            children: [
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    name ?? "sample text",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Text(
          //   name,
          //   style: GoogleFonts.poppins(
          //     color: Colors.white,
          //     fontSize: 10.5,
          //     decoration: TextDecoration.none,
          //   ),
          // ),
        ],
      ),
      onTap: () {},
    );
  }
}
