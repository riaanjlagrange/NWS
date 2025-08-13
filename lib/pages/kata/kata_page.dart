import 'package:flutter/material.dart';
import 'package:nws/pages/nav_page.dart';

class KataPage extends StatelessWidget implements NavPage {
  const KataPage({super.key});

  @override
  List<Widget> get appBarActions => [];

  @override
  String get title => 'Kata';

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Kata Page'));
  }
}
