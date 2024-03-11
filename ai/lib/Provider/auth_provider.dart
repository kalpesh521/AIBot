import 'package:ai/Screens/get_started_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProviderState extends ChangeNotifier {
  String? _uid;
  String? _email;
  String? _firstName;
  String? _lastName;

  String? get getUid => _uid;
  String? get getEmail => _email;
  String? get getFirstName => _firstName;
  String? get getLastName => _lastName;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> signUpUser(
      String email, String password, String firstName, String lastName) async {
    bool retval = false;

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email;
        _firstName = firstName;
        _lastName = lastName;

        await _firestore.collection('users').doc(_uid).set({
          'uid': _uid,
          'email': _email,
          'firstName': _firstName,
          'lastName': _lastName,
        });

        retval = true;
      }
    } catch (e) {
      print(e);
    }

    return retval;
  }

  Future<bool> loginUser(String email, String password) async {
    bool retval = false;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email;

        DocumentSnapshot userData =
            await _firestore.collection('users').doc(_uid).get();
        if (userData.exists) {
          _firstName = userData['firstName'];
          _lastName = userData['lastName'];
        }

        retval = true;
      }
    } catch (e) {
      print(e);
    }

    return retval;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          _uid = user.uid;
          _email = user.email;

          DocumentSnapshot userData =
              await _firestore.collection('users').doc(_uid).get();
          if (userData.exists) {
            _firstName = userData['firstName'];
            _lastName = userData['lastName'];
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => GetStarted()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You are Successfully Logged In !',
            style: TextStyle(fontWeight: FontWeight.bold)),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}
