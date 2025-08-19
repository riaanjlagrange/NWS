import 'package:flutter/material.dart';
import 'package:nws/pages/auth/auth_page.dart';
import 'package:nws/pages/auth/signin_page.dart';
import 'package:nws/pages/auth/signup_page.dart';
import 'package:nws/pages/dashboard/dashboard_page.dart';
import 'package:nws/pages/kata/kata_page.dart';
import 'package:nws/pages/profile/profile_page.dart';
import 'package:nws/pages/videos/videos_categories_page.dart';

class AppRoutes {
  static const dashboard = '/dashboard';
  static const videosCategories = '/videos-categories';
  static const kata = '/kata';
  static const profile = '/profile';
  static const auth = '/auth';
  static const signup = '/signup';
  static const signin = '/signin';

  static Map<String, WidgetBuilder> get routes => {
    dashboard: (context) => const DashboardPage(),
    videosCategories: (context) => const VideosCategoriesPage(),
    kata: (context) => const KataPage(),
    profile: (context) => const ProfilePage(),
    auth: (context) => const AuthPage(),
    signup: (context) => const SignUpPage(),
    signin: (context) => const SignInPage(),
  };
}
