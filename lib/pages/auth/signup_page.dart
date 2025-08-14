import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nws/blocs/auth/auth_bloc.dart';
import 'package:nws/blocs/auth/auth_event.dart';
import 'package:nws/blocs/auth/auth_state.dart';
import 'package:nws/components/custom_button.dart';
import 'package:nws/components/custom_textfield.dart';
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

  // sign in with google
  void signInWithGoogle() {
    context.read<AuthBloc>().add(SignInWithGoogleRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final dividerColor = theme.dividerTheme.color ?? Colors.grey;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      // listen to authbloc for state changes
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // if login success, go to dashboard or home screen
          if (state is AuthError) {
            // else show a toast to display the error message to the user
            // TODO: refactor this, I think it should rather belong in the auth page
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

                // title
                Text(
                  "Create An Account",
                  style: textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),

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

                // sign up button
                CustomButton(text: "Sign Up", onTap: signUserUp),

                SizedBox(height: 25.0),

                // or continue with google
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.5, color: dividerColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "OR CONTINUE WITH",
                          style: textTheme.bodySmall?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 0.5, color: dividerColor),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.0),

                // sign in with google button
                SquareTile(
                  imagePath: "assets/images/google_logo.png",
                  onTap: () => SignInWithGoogleRequested,
                ),

                SizedBox(height: 30.0),

                // already a member? login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member?", style: textTheme.bodyMedium),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: theme.colorScheme.primary,
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
