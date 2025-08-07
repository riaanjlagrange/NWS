import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nws/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up method
  Future<UserModel> signUp({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    String role = 'user',
  }) async {
    try {
      // check if passwords match
      if (password != confirmPassword) {
        throw FirebaseAuthException(code: "unmatched-passwords");
      }

      // create user with email and password
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // get user's uid
      final String uid = result.user!.uid;

      // save custom user data to Firestore
      final UserModel user = UserModel(
        uid: uid,
        email: email,
        username: username,
        role: role,
      );

      // store user data to firestore
      await _firestore.collection('users').doc(uid).set(user.toMap());

      // return the user to be used in bloc
      return user;
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
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // sign user in with email and password
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // get user id
      final uid = result.user!.uid;

      // try to get user data from firestore using uid
      final doc = await _firestore.collection('users').doc(uid).get();

      // throw exception if user is not found
      if (!doc.exists) {
        throw Exception("User data not found");
      }

      // convert to usermodel and return user
      return UserModel.fromMap(uid, doc.data()!);
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
