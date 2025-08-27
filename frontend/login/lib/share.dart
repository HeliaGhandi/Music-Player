import 'dart:async'; // Import the dart:async library

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/content-display.dart';
import 'package:login/main.dart';
import 'dart:math';
import 'package:login/json-handler.dart';

class Share extends StatefulWidget {
  void Function() finalize;
  Share({super.key, required this.finalize});
  @override
  State<Share> createState() => _ShareState();
}

class _ShareState extends State<Share> {
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
            SizedBox(height: deviceHeight - 360),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: deviceWidth - 50,
                height: 300,
                alignment: Alignment.center,

                decoration: BoxDecoration(
                  color:
                      UserInfo.isDark
                          ? darkTheme.primaryColor
                          : const Color.fromRGBO(225, 148, 174, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),

        Column(
          children: [
            SizedBox(height: deviceHeight - 350),
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
                SizedBox(
                  width: deviceWidth - 70,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...UserInfo.usernamesThatIVEAlreadySharedASongWith.map((
                          username,
                        ) {
                          return UserProfileGerdali(username: username);
                        }),
                        Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                              child: Icon(
                                Icons.search,
                                size: 35,
                                color: const Color.fromARGB(255, 68, 67, 67),
                              ),
                            ),
                            Text(
                              "search",
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
