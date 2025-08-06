import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nws/pages/signin_page.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // prevent user from swiping back to login screen
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                // dispatch sign-out event
                context.read<AuthBloc>().add(SignOutRequested());
              },
              icon: const Icon(Icons.logout),
              tooltip: 'Sign Out',
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              // Get the currently signed-in user's email
              final user = FirebaseAuth.instance.currentUser;

              if (user == null) {
                return SignInPage();
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome! You are signed in.',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: ${user!.email}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
