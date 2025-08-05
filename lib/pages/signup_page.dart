import 'package:flutter/material.dart';
import 'package:nws/components/custom_button.dart';
import 'package:nws/components/custom_textfield.dart';
import 'package:nws/components/square_tile.dart';
import 'package:nws/core/constants.dart';
import 'package:nws/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // input controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // sign up
  void signUserUp() async {
    // show loading indicator
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // try to sign up
    await AuthService().signUp(
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    // pop the loading circle
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50.0),

            // logo
            Image.asset("assets/images/nws_logo.png", height: 100),

            SizedBox(height: 50.0),

            // welcome back, you've been missed
            Text("Create An Account", style: kSoftHeading),

            SizedBox(height: 25.0),

            // Email textfield
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

            // sign up
            CustomButton(text: "Sign Up", onTap: signUserUp),

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
    );
  }
}
