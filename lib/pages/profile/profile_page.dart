import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nws/blocs/auth/auth_bloc.dart';
import 'package:nws/blocs/auth/auth_event.dart';
import 'package:nws/pages/nav_page.dart';

class ProfilePage extends StatelessWidget implements NavPage {
  const ProfilePage({super.key});

  @override
  List<Widget> get appBarActions => [
    Builder(
      builder: (context) => IconButton(
        onPressed: () {
          // TODO: fix sign out session. You are not able to sign in again after signout out with this
          context.read<AuthBloc>().add(SignOutRequested());
          Navigator.pushReplacementNamed(context, '/signin');
        },
        icon: const Icon(Icons.logout),
        tooltip: 'Sign Out',
      ),
    ),
  ];

  @override
  String get title => 'Profile';

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Page'));
  }
}
