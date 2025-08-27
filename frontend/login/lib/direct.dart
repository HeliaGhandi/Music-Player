import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/main.dart';
import 'package:login/navigation-bar.dart';
import 'package:login/music-bar.dart';
import 'package:login/content-display.dart';
import 'package:login/ios-keyboard.dart';

class Direct extends StatefulWidget {
  void Function() changeToHome;
  void Function() changeToMusic;
  void Function() changeToChat;

  bool? isDark;
  Direct({
    this.isDark,
    required this.changeToHome,
    required this.changeToChat,
    required this.changeToMusic,
  });
  double space = 25;
  State<Direct> createState() {
    return _DirectScreenWidget();
  }
}

class _DirectScreenWidget extends State<Direct> {
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
                    TextButton(
                      onPressed: () {
                        widget.changeToHome();
                      },
                      child: Icon(Icons.arrow_back_ios_new, size: 35),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Direct Messages",
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
                SizedBox(height: 35),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      setState(() {
                        _showCustomKeyboard = true;
                      });
                    },
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
                      hintText: "Search For Users",

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
                Divider(thickness: 3),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: deviceHeight + 190,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          UserCard(
                            username: "HELIA",
                            isOnline: true,
                            unread: true,
                            changeToChat: widget.changeToChat,
                          ),
                          UserCard(
                            username: "ILIYA",
                            isOnline: false,
                            changeToChat: widget.changeToChat,
                          ),
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
                SizedBox(height: deviceHeight - 120),
                // Use CachedMusicBar for enhanced music playback with caching
                CachedMusicBar(changeToFullScreen: widget.changeToMusic),
                // Or use the original MusicBar for JSON-based streaming:
                // MusicBar(changeToFullScreen: widget.changeToMusic,),
                SizedBox(height: 5),
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

class UserCard extends StatelessWidget {
  String username;
  bool? isOnline;
  bool? unread;
  void Function() changeToChat;
  UserCard({
    required this.username,
    required this.changeToChat,
    this.isOnline,
    this.unread,
  });

  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;

    return TextButton(
      onPressed: () {
        changeToChat();
      },
      child: Stack(
        children: [
          SizedBox(
            width: deviceWidth,
            height: 75,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  SizedBox(height: 14.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Container(
                            width: 60,
                            height: 60,

                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(UserInfo.profilePictureURL),
                              ),
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                          ),

                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: GoogleFonts.lato(
                                  fontSize: 24,
                                  decoration: TextDecoration.none,
                                  color:
                                      UserInfo.isDark
                                          ? darkTheme.focusColor
                                          : lightTheme.focusColor,
                                ),
                              ),
                              Text(
                                'last chat',
                                style: GoogleFonts.lato(
                                  fontSize: 17,
                                  decoration: TextDecoration.none,
                                  color:
                                      UserInfo.isDark
                                          ? darkTheme.focusColor
                                          : lightTheme.focusColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              unread ?? false
                                  ? Colors.blue
                                  : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 55),
              Row(
                children: [
                  SizedBox(width: 70),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isOnline ?? false ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
