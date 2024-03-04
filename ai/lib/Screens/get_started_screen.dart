import 'dart:async';
import 'package:ai/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class GetStarted extends StatefulWidget {
  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: ClipPath(
                clipper: ClipUpClipper(),
                child: Container(
                  height: 100,
                  width: 100,
                  color: Color(0xFFFFE8C7),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 120),
                Image.asset(
                  'assets/images/ai-bot.png',
                  width: 300,
                  height: 300,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 30),
                    Text(
                      'Advanced Mobile Features: ',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 30),
                    Text(
                      'VoiceChat, Image Generation',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 30),
                    Text(
                      ' ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      ' and PDF Summarization',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Container(
                    height: 5,
                    width: 130,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 45),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: HomeScreen(),
                          type: PageTransitionType.leftToRight,
                          duration: Duration(milliseconds: 700),
                        ),
                      );
                    },
                    child: Text(
                      "GET STARTED",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(67, 2, 102, 1),
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 35),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: ClipPath(
                      clipper: clipDownClipper(),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Color(0xFFEAD4EA),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ClipUpClipper extends CustomClipper<Path> {
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(0, size.height, 0, 0);

    return path;
  }

  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class clipDownClipper extends CustomClipper<Path> {
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.width, 0, 0, 0);

    return path;
  }

  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
