import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Sign up method
  Future<void> signUp({
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
    } on FirebaseAuthException catch (e) {
      // handles different errors accordingly
      // and set a message based on the error
      String message;

      switch (e.code) {
        case "weak-password":
          message = "The password provided is too weak.";
          break;
        case "email-already-in-use":
          message = "An account already exists with that email.";
          break;
        case "unmatched-passwords":
          message = "Passwords do not match.";
          break;
        default:
          message = "Something went wrong.";
      }

      throw Exception(message);
    }
  }

  // sign in method
  Future<void> signIn({required String email, required String password}) async {
    try {
      // sign user in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // handles different errors accordingly
      // and set a message based on the error
      String message;

      switch (e.code) {
        case "user-not-found":
          message = "No user found for that email.";
          break;
        case "wrong-password":
          message = "Wrong password provided for that user.";
          break;
        case "invalid-credential":
          message = "Email or password is incorrect.";
          break;
        default:
          message = "Something went wrong.";
      }

      throw Exception(message);
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
