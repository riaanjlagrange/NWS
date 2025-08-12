import 'package:flutter/material.dart';
import 'package:nws/pages/nav_page.dart';

class ProfilePage extends StatelessWidget implements NavPage {
  const ProfilePage({super.key});

  @override
  List<Widget> get appBarActions => [];

  @override
  String get title => 'Profile';

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Page'));
  }
}
