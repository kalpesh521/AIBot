import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProviderState extends ChangeNotifier {
  String? _uid;
  String? _email;

  String? get getUid => _uid;
  String? get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpUser(String email, String password) async {
    bool retval = false;

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email;
        return retval = true;
      }
    } catch (e) {
      print(e);
    }

    return retval;
  }

  Future<bool> LoginUser(String email, String password) async {
    bool retval = false;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email;
        return retval = true;
      }
    } catch (e) {
      print(e);
    }

    return retval;
  }

  void signOut() async {
    await _auth.signOut();
  }
}
