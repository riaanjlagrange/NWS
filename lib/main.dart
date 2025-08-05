import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nws/firebase_options.dart';
import 'package:nws/pages/auth_page.dart';
import 'package:nws/pages/dashboard_page.dart';
import 'package:nws/pages/signin_page.dart';
import 'package:nws/pages/signup_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: SignInPage()),
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => AuthPage(),
        '/signin': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}
