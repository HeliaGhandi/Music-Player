import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationScreen extends StatelessWidget {
  void Function() changeToSignUp;
  void Function() changeToLogin;
  AuthenticationScreen({
    super.key,
    required this.changeToSignUp,
    required this.changeToLogin,
  });
  @override
  Widget build(BuildContext context) {
    double? deviceWidth = MediaQuery.of(context).size.width;
    double? deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 70),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: deviceHeight * 3.30 / 5),
          SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: changeToSignUp,
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 240, 181, 117),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200),
                ),

                foregroundColor: Colors.black,
              ),
              child: Text(
                "Sign Up for free",
                style: GoogleFonts.poppins(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                changeToLogin();
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200),
                ),
                side: BorderSide(
                  color: Color.fromARGB(255, 240, 181, 117),
                  width: 1,
                ),
                foregroundColor: Color.fromARGB(255, 240, 181, 117),
              ),
              child: Text("Login", style: GoogleFonts.poppins(fontSize: 18)),
            ),
          ),
          SizedBox(height: 15),

          SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xFFFFF4EA),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200),
                ),
                side: BorderSide(
                  color: Color.fromARGB(255, 240, 181, 117),
                  width: 1,
                ),
                foregroundColor: Colors.black,
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/google-logo.png", width: 30),
                  SizedBox(width: 6),
                  Text(
                    "CONTINUE WITH GOOGLE",
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
