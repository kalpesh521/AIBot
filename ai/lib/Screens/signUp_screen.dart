import 'package:ai/Provider/auth_provider.dart';
import 'package:ai/Screens/signIn_screen.dart';
import 'package:ai/Screens/get_started_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ai/utils/components/my_button.dart';
import 'package:ai/utils/components/my_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final firestore = FirebaseFirestore.instance;
  late bool _obscureText = true;
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  void _signUp(String email, String password, BuildContext context) async {
    ProviderState _providerState =
        Provider.of<ProviderState>(context, listen: false);
    try {
      if (await _providerState.signUpUser(
          email, password, firstname.text, lastname.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You are Successfully registered !'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
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
              const SizedBox(height: 130),

              Text(
                'Create Account ',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 40),

              MyTextField(
                controller: firstname,
                hintText: 'First Name',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              MyTextField(
                controller: lastname,
                hintText: 'Last Name',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              MyTextField(
                controller: email,
                hintText: 'Email',
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

              // sign in button
              MyButton(
                onTap: () => _signUp(email.text, password.text, context),
                buttonText: "SIGN  UP",
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already an Account ?',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Sign In",
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
