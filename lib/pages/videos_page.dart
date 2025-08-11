import 'package:flutter/material.dart';
import 'package:nws/components/custom_bottom_nav_bar.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Videos')),
      body: const Center(child: Text('Videos Page')),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}
