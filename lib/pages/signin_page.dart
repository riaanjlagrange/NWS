import 'package:flutter/material.dart';
import 'package:nws/components/custom_button.dart';
import 'package:nws/components/custom_textfield.dart';
import 'package:nws/components/square_tile.dart';
import 'package:nws/core/constants.dart';
import 'package:nws/services/auth_service.dart';

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
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // try to sign in
    await AuthService().signIn(
      email: _emailController.text,
      password: _passwordController.text,
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
            Text("Welcome To NWS", style: kSoftHeading),

            SizedBox(height: 25.0),

            // email textfield
            CustomTextField(
              controller: _emailController,
              hintText: "Email",
              obscureText: false,
            ),

            SizedBox(height: 25.0),

            // password textfield
            CustomTextField(
              controller: _passwordController,
              hintText: "Password",
              obscureText: true,
            ),

            SizedBox(height: 10.0),

            // forgot password?
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

            SizedBox(height: 20.0),

            // sign in
            CustomButton(text: "Sign In", onTap: signUserIn),

            SizedBox(height: 30.0),

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

            SizedBox(height: 25.0),

            // sign in with google button
            SquareTile(imagePath: "assets/images/google_logo.png"),

            SizedBox(height: 25.0),

            // not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member?"),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/signup");
                  },
                  child: Text(
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
    );
  }
}
