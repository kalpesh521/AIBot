import 'package:ai/Screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ai/Screens/dashboard_screen.dart';
import 'package:ai/Screens/registration_screen.dart';
//  import 'package:flutter_login_ui/Screen/ForgotPassword.dart';
//  import 'file:///C:/Android%20Studio%20Stuff/Flutter%20Project/flutter_login_ui/lib/Widgets/SocialSignWidgetRow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:ai/Provider/auth_provider.dart';

class ProviderLogin extends StatefulWidget {
  @override
  _ProviderLoginState createState() => _ProviderLoginState();
}

class _ProviderLoginState extends State<ProviderLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeightBox(10),
                "Login".text.color(Colors.black).size(20).make(),
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
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
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
                    controller: pass,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
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

                // GestureDetector(onTap: (){
                //   // Get.to(ForgotPassword());
                // },
                //   child: Text("Forgot Password ? Reset Now",style: TextStyle(color: Colors.white),),),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProviderRegistration()));
                  },
                  child: Text(
                    "New user ? Register Now",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                HeightBox(20),

                HeightBox(10),
                GestureDetector(
                    onTap: () {
                      print("Login Clicked Event");
                      _Login(email.text, pass.text, context);
                    },
                    child: "LOGIN"
                        .text
                        .white
                        .light
                        .xl
                        .makeCentered()
                        .box
                        .white
                        .shadowOutline(outlineColor: Colors.grey)
                        .color(Color(0XFFFF0772))
                        .roundedLg
                        .make()
                        .w(150)
                        .h(40)),
                HeightBox(20),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _Login(String email, String password, BuildContext context) async {
    ProviderState _providerState =
        Provider.of<ProviderState>(context, listen: false);
    try {
      if (await _providerState.LoginUser(email, password)) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));

        Fluttertoast.showToast(
          msg: 'Successfully Logged In',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
