import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nws/components/loader.dart';
import 'package:nws/core/constants.dart';

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
        backgroundColor: kBGColor,
        appBar: AppBar(
          title: const Text('Dashboard'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                // dispatch sign-out event
                context.read<AuthBloc>().add(SignOutRequested());
                // navigate back to auth page to redirect accordingly
                Navigator.pushReplacementNamed(context, '/auth');
              },
              icon: const Icon(Icons.logout),
              tooltip: 'Sign Out',
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10),
          child: GNav(
            backgroundColor: Colors.white,
            tabBorderRadius: 15,
            haptic: true,
            gap: 8,
            tabs: const [
              GButton(icon: Icons.home, text: "Home"),
              GButton(icon: Icons.play_arrow, text: "Videos"),
              GButton(icon: Icons.photo, text: "Kata"),
              GButton(icon: Icons.face, text: "Profile"),
            ],
          ),
        ),
        body: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              // if the state is loading
              if (state is AuthLoading) {
                // show loader
                return Loader(color: Colors.indigo, size: 40.0);
              }

              // if user is authenticated, show user data
              if (state is AuthAuthenticated) {
                final user = state.user;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome! You are signed in.',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Username: ${user.username}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Email: ${user.email}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Role: ${user.role}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                );
              }

              // otherwise just show not authenticated, but the user shouldn't ever see this
              return const Text("Not authenticated");
            },
          ),
        ),
      ),
    );
  }
}
