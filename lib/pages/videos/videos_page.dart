import 'package:flutter/material.dart';
import 'package:nws/pages/nav_page.dart';

class VideosPage extends StatelessWidget implements NavPage {
  const VideosPage({super.key});

  @override
  List<Widget> get appBarActions => [];

  @override
  String get title => 'Videos';

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Videos Page'));
  }
}
