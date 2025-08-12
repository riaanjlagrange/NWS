import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nws/pages/nav_page.dart';
import '../core/constants.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';

class DashboardPage extends StatelessWidget implements NavPage {
  const DashboardPage({super.key});

  @override
  String get title => 'Dashboard';

  @override
  List<Widget> get appBarActions => [
    Builder(
      builder: (context) => IconButton(
        onPressed: () {
          context.read<AuthBloc>().add(SignOutRequested());
          Navigator.pushReplacementNamed(context, '/signin');
        },
        icon: const Icon(Icons.logout),
        tooltip: 'Sign Out',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final user = context.select(
      (AuthBloc bloc) => (bloc.state is AuthAuthenticated)
          ? (bloc.state as AuthAuthenticated).user
          : null,
    );

    if (user == null) {
      return const Center(child: Text('Not authenticated'));
    }

    return Center(
      child: Column(
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
          Text("Email: ${user.email}", style: const TextStyle(fontSize: 16)),
          Text("Role: ${user.role}", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
