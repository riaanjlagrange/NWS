import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nws/blocs/auth/auth_bloc.dart';
import 'package:nws/blocs/auth/auth_event.dart';
import 'package:nws/firebase_options.dart';
import 'package:nws/pages/auth_page.dart';
import 'package:nws/pages/dashboard_page.dart';
import 'package:nws/pages/signin_page.dart';
import 'package:nws/pages/signup_page.dart';
import 'package:nws/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authService = AuthService();

  runApp(
    BlocProvider(
      create: (_) =>
          AuthBloc(authService)
            ..add(AppStarted()), // automatically check login status
      child: const MyApp(),
    ),
  );
}

// Root of your app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
