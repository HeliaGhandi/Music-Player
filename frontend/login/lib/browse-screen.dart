import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/navigation-bar.dart';
import 'package:login/music-bar.dart';

class BrowseScreen extends StatefulWidget {
  void Function() changeToHome;
  void Function() changeToBrowse;
  void Function() changeToMusic;
  BrowseScreen({required this.changeToHome, required this.changeToBrowse , required this.changeToMusic});
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

    _searchController = TextEditingController(
      text: "What do you want to listen to?",
    );

    // Set cursor position at index 2
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: 2),
    );
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
              decoration: BoxDecoration(color: Colors.black),
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
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
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
                        color: Colors.white,
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
                      // height: deviceHeight - 100,
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
                MusicBar(changeToFullScreen: widget.changeToMusic,),
                SizedBox(height: 5),
                NavigationBari(
                  select: 2,
                  changeToBrowse: widget.changeToBrowse,
                  changeToHome: widget.changeToHome,
                ),
              ],
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
