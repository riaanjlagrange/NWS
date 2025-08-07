import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nws/blocs/auth/auth_bloc.dart';
import 'package:nws/blocs/auth/auth_event.dart';
import 'package:nws/blocs/auth/auth_state.dart';
import 'package:nws/components/custom_button.dart';
import 'package:nws/components/custom_textfield.dart';
import 'package:nws/components/loader.dart';
import 'package:nws/components/square_tile.dart';
import 'package:nws/core/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // input controllers
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // sign up
  // update this to use bloc
  void signUserUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    context.read<AuthBloc>().add(
      SignUpRequested(username, email, password, confirmPassword),
    );
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
          } else if (state is AuthError) {
            // else show a toast to display the error message to the user
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0,
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.0),

                // logo
                Image.asset("assets/images/nws_logo.png", height: 100),

                SizedBox(height: 50.0),

                // welcome message
                Text("Create An Account", style: kSoftHeading),

                SizedBox(height: 25.0),

                // username textfield
                CustomTextField(
                  controller: _usernameController,
                  hintText: "Username",
                  obscureText: false,
                ),

                SizedBox(height: 15.0),

                // email textfield
                CustomTextField(
                  controller: _emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                SizedBox(height: 15.0),

                // password textfield
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                SizedBox(height: 15.0),

                // confirm password
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),

                SizedBox(height: 50.0),

                // sign in button
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    // show loading spinner while signing in
                    if (state is AuthLoading) {
                      return Loader(color: Colors.indigo, size: 20.0);
                    }

                    // otherwise, show button
                    return CustomButton(text: "Sign Up", onTap: signUserUp);
                  },
                ),

                SizedBox(height: 25.0),

                // or continue with google
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "OR CONTINUE WITH",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.0),

                // sign in with google button
                SquareTile(imagePath: "assets/images/google_logo.png"),

                SizedBox(height: 30.0),

                // already a member? login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member?"),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign In",
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
