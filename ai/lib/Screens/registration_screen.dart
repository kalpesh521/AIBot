import 'dart:async';

import 'package:ai/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:ai/Provider/auth_provider.dart';

class ProviderRegistration extends StatefulWidget {
  @override
  _ProviderRegistrationState createState() => _ProviderRegistrationState();
}

class _ProviderRegistrationState extends State<ProviderRegistration> {
  final TextEditingController firstn = TextEditingController();
  final TextEditingController lastn = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  void _signUp(String email, String password, BuildContext context) async {
    ProviderState _providerState =
        Provider.of<ProviderState>(context, listen: false);
    try {
      if (await _providerState.signUpUser(email, password)) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ProviderLogin()));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You are Successfully registered !'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/auth_bg.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeightBox(150),
                  "Registration".text.color(Colors.black).size(20).make(),
                  HeightBox(20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      controller: firstn,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      ),
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  HeightBox(20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      controller: lastn,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      ),
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  HeightBox(20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      ),
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  HeightBox(20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      controller: password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      ),
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  HeightBox(20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProviderLogin()));
                    },
                    child: Text(
                      "Already an Account ? Sign In",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  HeightBox(20),
                  GestureDetector(
                    onTap: () {
                      _signUp(email.text, password.text, context);
                    },
                    child: Container(
                      height: 50,
                      width: 115,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 215, 140, 215), // Pink color
                            Color.fromARGB(255, 128, 0, 128), // Purple color
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  HeightBox(340),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
