import 'package:flutter/material.dart';
import 'package:nws/components/custom_bottom_nav_bar.dart';

class KataPage extends StatelessWidget {
  const KataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kata')),
      body: const Center(child: Text('Kata Page')),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}
