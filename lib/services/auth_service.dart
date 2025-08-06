import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  // Sign up method
  Future<bool> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      // check if passwords match
      if (password != confirmPassword) {
        throw FirebaseAuthException(code: "unmatched-passwords");
      }

      // create user with email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      // handles different errors accordingly
      // and set a message based on the error
      String message = 'Something went wrong.';
      if (e.code == "weak-password") {
        message = "The password provided is too weak.";
      } else if (e.code == "email-already-in-use") {
        message = "An account already exists with that email.";
      } else if (e.code == "unmatched-passwords") {
        message = "Passwords do not match";
      }

      // Then show a toast to display that message to the user
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      return false;
    }
  }

  // sign in method
  Future<bool> signIn({required String email, required String password}) async {
    try {
      // sign user in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      // handles different errors accordingly
      // and set a message based on the error
      String message = 'Something went wrong.';
      if (e.code == "user-not-found") {
        message = "No user found for that email.";
      } else if (e.code == "wrong-password") {
        message = "Wrong password provided for that user.";
      }

      // Then show a toast to display that message to the user
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      return false;
    }
  }

  // sign out method
  Future<void> signOut() async {
    // sign the user out
    await FirebaseAuth.instance.signOut();
  }

  // check if someone is signed in
  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  // get current user ID
  String currentUserUid() {
    return FirebaseAuth.instance.currentUser?.uid ?? '';
  }
}
