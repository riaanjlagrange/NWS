import 'package:flutter/material.dart';
import 'package:nws/pages/dashboard_page.dart';
import 'package:nws/pages/signin_page.dart';
import 'package:nws/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: SignInPage()),
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/dashboard': (context) => Dashboard(),
      },
    );
  }
}
