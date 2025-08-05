import 'package:flutter/material.dart';
import 'package:nws/services/auth_service.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => AuthService().signOut(),
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: const Center(child: Text('Welcome! You are signed in.')),
      ),
    );
  }
}
