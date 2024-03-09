import 'package:ai/Provider/auth_provider.dart';
import 'package:ai/Screens/signUp_screen.dart';
import 'package:ai/Screens/get_started_screen.dart';
import 'package:flutter/material.dart';
import 'package:ai/utils/components/my_button.dart';
import 'package:ai/utils/components/my_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late bool _obscureText = true;

  void _LoginUser(String email, String password, BuildContext context) async {
    ProviderState _providerState =
        Provider.of<ProviderState>(context, listen: false);
    try {
      if (await _providerState.loginUser(email, password)) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => GetStarted()));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 120),
              Image.asset("assets/images/bot.png", width: 130, height: 130),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Aura',
                    style: TextStyle(
                      color: Color.fromARGB(255, 30, 190, 239),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  '.ai',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              const SizedBox(height: 15),
              Text(
                'Welcome Back !',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: email,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: password,
                hintText: 'Password',
                obscureText: _obscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText =
                          !_obscureText; // Toggle password visibility
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              MyButton(
                onTap: () => _LoginUser(email.text, password.text, context),
                buttonText: "SIGN IN",
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New user ?',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: Text(
                      " Register Now",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
