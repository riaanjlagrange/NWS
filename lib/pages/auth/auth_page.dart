import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nws/blocs/auth/auth_bloc.dart';
import 'package:nws/blocs/auth/auth_state.dart';
import 'package:nws/pages/auth/signin_page.dart';
import 'package:nws/pages/loader_page.dart';
import 'package:nws/pages/main_scaffold.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // show UI based on different auth states
        if (state is AuthAuthenticated) {
          // if the the user is authenticated, show the dashboard
          return const MainScaffold();
        } else if (state is AuthLoading) {
          return const LoaderPage(color: Colors.indigo, size: 40.0);
        } else {
          // else the user must not be authenticated, so show the sign in page
          return const SignInPage();
        }
      },
    );
  }
}
