import 'dart:async';
import 'package:ai/Screens/signIn_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          duration: Duration(milliseconds: 370), // Set the transition duration
          child: LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).colorScheme.primary,
      body: Container(
        color:  Theme.of(context).colorScheme.primary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image.asset(
                'assets/images/bot.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Aura',
                      style: TextStyle(
                        color:  Color.fromARGB(255, 30, 190, 239),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    '.ai',
                    style: TextStyle(
                      color:  Theme.of(context).colorScheme.onPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ].animate(interval: 500.ms).fade(duration: 3000.ms),
              ),
            ]
                .animate(interval: 500.ms)
                .slideY(duration: 3000.ms, curve: Curves.easeOut)
                .fade(duration: 2000.ms),
          ),
        ),
      ),
    );
  }
}
