import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nws/blocs/auth/auth_bloc.dart';
import 'package:nws/blocs/auth/auth_event.dart';
import 'package:nws/blocs/auth/auth_state.dart';
import 'package:nws/components/custom_button.dart';
import 'package:nws/components/custom_textfield.dart';
import 'package:nws/components/square_tile.dart';
import 'package:nws/core/constants.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SignInPage> {
  // input controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // sign in using Bloc
  void signUserIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // trigger bloc event for login
    context.read<AuthBloc>().add(SignInRequested(email, password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // listen to authbloc for state changes
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // if login success, go to dashboard or home screen
          if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, "/dashboard");
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // app logo
                Image.asset("assets/images/nws_logo.png", height: 100),

                const SizedBox(height: 50),

                // welcome text
                Text("Welcome To NWS", style: kSoftHeading),

                const SizedBox(height: 25),

                // email input
                CustomTextField(
                  controller: _emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                // password input
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // sign in button
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    // show loading spinner while signing in
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }

                    // otherwise, show button
                    return CustomButton(text: "Sign In", onTap: signUserIn);
                  },
                ),

                const SizedBox(height: 30),

                // OR divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "OR CONTINUE WITH",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // google sign in button
                SquareTile(imagePath: "assets/images/google_logo.png"),

                const SizedBox(height: 25),

                // register link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
