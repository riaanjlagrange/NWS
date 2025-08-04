import 'package:flutter/material.dart';
import 'package:nws/components/custom_button.dart';
import 'package:nws/components/custom_textfield.dart';
import 'package:nws/components/square_tile.dart';
import 'package:nws/core/constants.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  // input controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign in function
  void signUserIn() {}

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
            Image.asset("assets/images/nws_logo.jpeg", height: 100),

            SizedBox(height: 50.0),

            // welcome back, you've been missed
            Text("Create An Account", style: kSoftHeading),

            SizedBox(height: 25.0),

            // username textfield
            CustomTextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),

            SizedBox(height: 15.0),

            // username textfield
            CustomTextField(
              controller: usernameController,
              hintText: "Username",
              obscureText: false,
            ),

            SizedBox(height: 15.0),

            // password textfield
            CustomTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),

            SizedBox(height: 15.0),

            // confirm password
            CustomTextField(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              obscureText: true,
            ),

            SizedBox(height: 50.0),

            // sign in
            CustomButton(text: "Sign Up", onTap: signUserIn),

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
