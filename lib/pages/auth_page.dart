import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nws/blocs/auth/auth_bloc.dart';
import 'package:nws/blocs/auth/auth_state.dart';
import 'package:nws/pages/dashboard_page.dart';
import 'package:nws/pages/signin_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // show UI based on different auth states
        if (state is AuthLoading) {
          // if the auth state is loading, show a loading indicator
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthAuthenticated) {
          // if the the user is authenticated, show the dashboard
          return const DashboardPage();
        } else {
          // else the user must not be authenticated, so show the sign in page
          return const SignInPage();
        }
      },
    );
  }
}
