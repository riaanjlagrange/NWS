import 'package:flutter/material.dart';

import '../pages/dashboard_page.dart';
import '../pages/videos_page.dart';
import '../pages/kata_page.dart';
import '../pages/profile_page.dart';
import '../pages/auth_page.dart';

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
