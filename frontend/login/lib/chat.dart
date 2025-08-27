import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/authenticaion-text-field-format.dart';
import 'package:login/chat-message-text-field.dart';
import 'package:login/content-display.dart';
import 'package:login/main.dart';
import 'package:login/music-bar.dart';
import 'ios-keyboard.dart';

class Chat extends StatefulWidget {
  void Function() changeToDirect;
  void Function() changeToMusic;
  String? userIcon;
  String? username;
  bool? isOnline;
  Chat({
    required this.changeToDirect,
    required this.changeToMusic,
    this.userIcon,
    this.username,
    this.isOnline,
  });
  @override
  State<StatefulWidget> createState() {
    return _ChatState();
  }
}

class _ChatState extends State<Chat> {
  TextEditingController? messageController;
  bool _showCustomKeyboard = false;
  bool _isPasswordField = false;
  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  void _onKeyTap(String value) {
    final controller = messageController;
    controller!.text += value;
  }

  void _onBackspace() {
    final controller = messageController;
    if (controller!.text.isNotEmpty) {
      controller.text = controller.text.substring(
        0,
        controller.text.length - 1,
      );
    }
  }

  void _onReturn() {
    setState(() {
      _showCustomKeyboard = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:
          UserInfo.isDark
              ? darkTheme.scaffoldBackgroundColor
              : lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: deviceWidth,
                height: 100,
                color:
                    UserInfo.isDark
                        ? lightTheme.primaryColor
                        : darkTheme.primaryColor,
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 45),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        widget.changeToDirect();
                      },
                      child: Icon(Icons.arrow_back_ios_new, size: 35),
                    ),
                    // SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          widget.username ?? "Deleted Account",
                          style: GoogleFonts.lato(
                            fontSize: 19,
                            color:
                                UserInfo.isDark
                                    ? darkTheme.focusColor
                                    : lightTheme.focusColor,
                          ),
                        ),
                        widget.isOnline ?? false
                            ? Text(
                              "Online",
                              style: GoogleFonts.poppins(color: Colors.green),
                            )
                            : Text(
                              "Offline",
                              style: GoogleFonts.poppins(
                                color: const Color.fromARGB(255, 68, 68, 68),
                              ),
                            ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage(UserInfo.profilePictureURL),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Column(
            children: [
              SizedBox(height: 100),
              UserInfo.isDark
                  ? Image.asset("assets/user/dark-background.jpg")
                  : Image.asset("assets/user/light-background.jpg"),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 105),
              SizedBox(
                height: _showCustomKeyboard ? 420 : 650,
                width: deviceWidth,
                child: Container(color: Colors.transparent),
              ),
              //ChatTextInput(),
              ChatMessageTextField(
                hint: "message",
                color: Colors.grey,

                controller: messageController,
                onTap: () {
                  setState(() {
                    _showCustomKeyboard = true;
                    _isPasswordField = false;
                  });
                },
              ),
              CachedMusicBar(changeToFullScreen: widget.changeToMusic),
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
    );
  }
}
