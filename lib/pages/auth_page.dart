import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nws/pages/dashboard_page.dart';
import 'package:nws/pages/signin_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is already signed in
          if (snapshot.hasData) {
            // take them to the dashboard
            return DashboardPage();

            // if user is not signed in
          } else {
            // take them to the sign in page
            return SignInPage();
          }
        },
      ),
    );
  }
}
