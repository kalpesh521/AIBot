// // import 'dart:math';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/cupertino.dart';

// // class ProviderState extends ChangeNotifier {
// //   String? _uid;
// //   String? _email;

// //   String? get getUid => _uid;
// //   String? get getEmail => _email;

// //   FirebaseAuth _auth = FirebaseAuth.instance;

// //   Future<bool> signUpUser(String email, String password) async {
// //     bool retval = false;

// //     try {
// //       UserCredential userCredential = await _auth
// //           .createUserWithEmailAndPassword(email: email, password: password);

// //       if (userCredential.user != null) {
// //         _uid = userCredential.user!.uid;
// //         _email = userCredential.user!.email;
// //         return retval = true;
// //       }
// //     } catch (e) {
// //       print(e);
// //     }

// //     return retval;
// //   }

// //   Future<bool> LoginUser(String email, String password) async {
// //     bool retval = false;

// //     try {
// //       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
// //           email: email, password: password);

// //       if (userCredential.user != null) {
// //         _uid = userCredential.user!.uid;
// //         _email = userCredential.user!.email;
// //         return retval = true;
// //       }
// //     } catch (e) {
// //       print(e);
// //     }

// //     return retval;
// //   }

// //   void signOut() async {
// //     await _auth.signOut();
// //   }
// // }

// import 'dart:math';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';

// class ProviderState extends ChangeNotifier {
//   String? _uid;
//   String? _email;

//   String? get getUid => _uid;
//   String? get getEmail => _email;

//   FirebaseAuth _auth = FirebaseAuth.instance;
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<bool> signUpUser(String email, String password, String firstName, String lastName) async {
//     bool retval = false;

//     try {
//       UserCredential userCredential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password);

//       if (userCredential.user != null) {
//         _uid = userCredential.user!.uid;
//         _email = userCredential.user!.email;
        
//         // Storing user information in Firestore
//         await _firestore.collection('Users').doc(_uid).set({
//           'uid': _uid,
//           'email': _email,
//           'firstName': firstName,
//           'lastName': lastName,
//         });

//         retval = true;
//       }
//     } catch (e) {
//       print(e);
//     }

//     return retval;
//   }

//   Future<bool> LoginUser(String email, String password) async {
//     bool retval = false;

//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);

//       if (userCredential.user != null) {
//         _uid = userCredential.user!.uid;
//         _email = userCredential.user!.email;
//         retval = true;
//       }
//     } catch (e) {
//       print(e);
//     }

//     return retval;
//   }

//   void signOut() async {
//     await _auth.signOut();
//   }
// }
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProviderState extends ChangeNotifier {
  String? _uid;
  String? _email;
  String? _firstName; // Added first name variable
  String? _lastName; 
  int? _PhoneNumber;
  // Added last name variable

  String? get getUid => _uid;
  String? get getEmail => _email;
  String? get getFirstName => _firstName; // Getter for first name
  String? get getLastName => _lastName; // Getter for last name

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> signUpUser(String email, String password, String firstName, String lastName ) async {
    bool retval = false;

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email;
        _firstName = firstName;
        _lastName = lastName;
 
        // Storing user information in Firestore
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
        
        // Retrieve user information from Firestore
        DocumentSnapshot userData = await _firestore.collection('users').doc(_uid).get();
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

  void signOut() async {
    await _auth.signOut();
  }
}
