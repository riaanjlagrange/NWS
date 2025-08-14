import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nws/blocs/auth/auth_bloc.dart';
import 'package:nws/blocs/auth/auth_event.dart';
import 'package:nws/blocs/auth/auth_state.dart';
import 'package:nws/components/custom_button.dart';
import 'package:nws/components/custom_textfield.dart';
import 'package:nws/components/square_tile.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SignInPage> {
  // input controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // sign in
  void signIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // trigger bloc event for login
    context.read<AuthBloc>().add(SignInRequested(email, password));
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
      // set background color to the current theme
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // listen to authbloc for state changes
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // if login success, go to dashboard or home screen
          if (state is AuthError) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // app logo
                Image.asset("assets/images/nws_logo.png", height: 100),

                const SizedBox(height: 50),

                // welcome text
                Text(
                  "Welcome To NWS",
                  style: textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),

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

                // TODO: need to add functionality for this
                // forgot password text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // sign in button
                CustomButton(text: "Sign In", onTap: signIn),

                const SizedBox(height: 30),

                // OR divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.5, color: dividerColor),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "OR CONTINUE WITH",
                          style: textTheme.bodySmall?.copyWith(
                            color: theme.hintColor,
                          ),
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
                SquareTile(
                  imagePath: "assets/images/google_logo.png",
                  onTap: () => signInWithGoogle(),
                ),

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
                      child: Text(
                        "Sign Up",
                        style: textTheme.bodyMedium?.copyWith(
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
