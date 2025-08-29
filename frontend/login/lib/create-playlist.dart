import 'dart:async'; // Import the dart:async library

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/authenticaion-text-field-format.dart';
import 'package:login/content-display.dart';
import 'package:login/main.dart';
import 'dart:math';
import 'package:login/json-handler.dart';
import 'package:login/ios-keyboard.dart';
import 'package:login/notif.dart';
import 'package:login/playlist.dart';
import 'package:login/library.dart';

class CreatePlaylist extends StatefulWidget {
  void Function() finalize;
  void Function(PlayList) goToPlayListScreen;
  CreatePlaylist({
    super.key,
    required this.finalize,
    required this.goToPlayListScreen,
  });
  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  Notif? _currentNotif;
  TextEditingController? newPlayListController;
  bool _showCustomKeyboard = false;
  bool _isPasswordField = false;
  @override
  void initState() {
    super.initState();
    newPlayListController = TextEditingController();
  }

  void _onKeyTap(String value) {
    final controller = newPlayListController;
    controller!.text += value;
  }

  void _onBackspace() {
    final controller = newPlayListController;
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

  bool _isVisible = true;
  @override
  // void initState() {
  // super.initState();
  // Timer(const Duration(seconds: 7), () {
  // if (mounted) {
  // setState(() {
  // _isVisible = false;
  // });
  // widget.finalize();
  // }
  // });
  // }
  @override
  void dispose() {
    // You should also cancel the timer here if it's still active.
    // For this simple example, we'll assume the timer will always complete.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController playlistNameController = TextEditingController();
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    if (!_isVisible) {
      return const SizedBox.shrink(); // Return an empty widget if not visible
    }

    // double? deviceWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: deviceHeight - 560),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: deviceWidth - 50,
                height: 500,
                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color:
                      UserInfo.isDark
                          ? Colors.white
                          : const Color.fromRGBO(225, 148, 174, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),

        Column(
          children: [
            SizedBox(height: deviceHeight - 550),
            Container(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: 3 * pi / 2,
                    child: GestureDetector(
                      child: Icon(Icons.arrow_back_ios_new, size: 40),
                      onTap: () {
                        setState(() {
                          _isVisible = false;
                          widget.finalize();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(children: [SizedBox(width: 15)]),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 35),
                Text(
                  "Create a playlist ",
                  style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 34, 112, 247),
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 35),
                SizedBox(
                  width: deviceWidth - 70,
                  child: AuthenticationTextField(
                    hint: "PlayList name",
                    color: const Color.fromARGB(255, 0, 0, 0),
                    horizontalPadding: 10,
                    isPassword: false,
                    controller: newPlayListController,
                    onTap: () {
                      setState(() {
                        _isVisible = true;
                        _showCustomKeyboard = true;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 100,
              width: deviceWidth - 100,
              child: Text(
                "By creating a new Playlist You agree to terms of use\nothers may be able to see the playlists you create if your account is public even if they dont have an latte studio account.",
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 0, 47, 129),
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 105),
            OutlinedButton(
              style: OutlinedButton.styleFrom(fixedSize: Size(200, 40)),
              onPressed: () async {
                // <--- async اضافه شد
                Map<String, String> request = {
                  "command": "CREATE_PLAYLIST",
                  "playlistName": newPlayListController!.text,
                  "username": UserInfo.username,
                };
                // یک نمونه از JsonHandler ایجاد کرده و متد sendTestRequest را فراخوانی می‌کنیم
                // و منتظر پاسخ آن می‌مانیم.
                Map<String, dynamic> response =
                    await JsonHandler(
                      json: request,
                    ).sendTestRequest(); // <--- تغییر اصلی
                print('Server Response: $response');
                // <--- می‌توانید پاسخ سرور را اینجا چاپ کنید
                if (response["success"]) {
                  widget.goToPlayListScreen(
                    PlayList(
                      libraryName: newPlayListController!.text,
                      numberOfMusics: 0,
                      content: [],
                    ),
                  );
                } else {
                  setState(() {
                    _currentNotif = Notif(
                      text: 'Creating playlist failed: ${response['message']} ',
                      finalize: () {
                        setState(() {
                          _currentNotif = null;
                        });
                      },
                    );
                  });
                  Notif(
                    text: 'Creating playlist failed: ${response['message']} ',
                    color: Color(0xFFD2C3D8),
                    finalize: () {
                      setState(() {
                        _currentNotif = null;
                      });
                    },
                  );
                }
              },
              child: Text("Agree and Create"),
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
        if (_currentNotif != null) _currentNotif!,
      ],
    );
  }
}

class UserProfileGerdali extends StatefulWidget {
  String username;
  UserProfileGerdali({required this.username, super.key});
  @override
  State<StatefulWidget> createState() {
    return _UserProfileGerdaliState();
  }
}

class _UserProfileGerdaliState extends State<UserProfileGerdali> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            Map<String, String> request = {
              "command": "share_music",
              "fromUsername": UserInfo.username,
              "toUsername": widget.username,
              "musicURL": UserInfo.currentMusicUrl,
            };
            // یک نمونه از JsonHandler ایجاد کرده و متد sendTestRequest را فراخوانی می‌کنیم
            // و منتظر پاسخ آن می‌مانیم.
            Map<String, dynamic> response =
                await JsonHandler(
                  json: request,
                ).sendTestRequest(); // <--- تغییر اصلی
            print(
              'Server Response: $response',
            ); // <--- می‌توانید پاسخ سرور را اینجا چ
          },
          child: Column(
            children: [
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
              Text(
                (widget.username.length > 6)
                    ? (widget.username.substring(0, 5) + "...")
                    : widget.username,
                style: GoogleFonts.lato(
                  fontSize: 15,
                  color:
                      UserInfo.isDark
                          ? darkTheme.focusColor
                          : lightTheme.focusColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
