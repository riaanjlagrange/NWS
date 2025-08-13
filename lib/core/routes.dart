import 'package:flutter/material.dart';
import 'package:nws/pages/auth/auth_page.dart';
import 'package:nws/pages/dashboard/dashboard_page.dart';
import 'package:nws/pages/kata/kata_page.dart';
import 'package:nws/pages/profile/profile_page.dart';
import 'package:nws/pages/videos/videos_page.dart';

class AppRoutes {
  static const dashboard = '/dashboard';
  static const videos = '/videos';
  static const kata = '/kata';
  static const profile = '/profile';
  static const auth = '/auth';

  static Map<String, WidgetBuilder> get routes => {
    dashboard: (context) => const DashboardPage(),
    videos: (context) => const VideosPage(),
    kata: (context) => const KataPage(),
    profile: (context) => const ProfilePage(),
    auth: (context) => const AuthPage(),
  };
}
