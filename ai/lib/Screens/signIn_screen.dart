import 'package:ai/Provider/auth_provider.dart';
import 'package:ai/Screens/signUp_screen.dart';
import 'package:ai/Screens/get_started_screen.dart';
import 'package:ai/utils/components/square_tile.dart';
import 'package:flutter/material.dart';
import 'package:ai/utils/components/my_button.dart';
import 'package:ai/utils/components/my_textfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late bool _obscureText = true;
  bool _isSigningIn = false; // Indicator for sign in process

  void _loginUser(BuildContext context) async {
    setState(() {
      _isSigningIn = true; // Show progress indicator
    });
    ProviderState _providerState = Provider.of<ProviderState>(context, listen: false);
    try {
      if (await _providerState.loginUser(email.text, password.text)) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetStarted()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You are Successfully Logged In !', style: TextStyle(fontWeight: FontWeight.bold)),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ));
      }else{
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Incorrect Credentials', style: TextStyle(fontWeight: FontWeight.bold)),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
       
    } finally {
      setState(() {
        _isSigningIn = false;  
      });
    }
  }

  void _signInWithGoogle(BuildContext context) async {
    setState(() {
      _isSigningIn = true; // Show progress indicator
    });
    ProviderState _providerState = Provider.of<ProviderState>(context, listen: false);
    try {
      await _providerState.signInWithGoogle(context);
    } finally {
      setState(() {
        _isSigningIn = false; // Hide progress indicator
      });
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
              const SizedBox(height: 90),
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
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _isSigningIn
                  ? CircularProgressIndicator( color: Colors.grey.shade400, strokeWidth: 4) // Show progress indicator when signing in
                  : MyButton(
                      onTap: () => _loginUser(context),
                      buttonText: "SIGN IN",
                    ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SquareTile(
                  imagePath: 'assets/images/google.png',
                  onPressed: () {
                    _signInWithGoogle(context);
                  },
                ),
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
