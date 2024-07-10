import 'package:auth_demo/components/my_button.dart';
import 'package:auth_demo/components/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:auth_demo/helper/helper_methods.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  void loginUser(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      // Navigate to the HomePage after successful login
      Navigator.pop(context); // Remove the loading indicator
      Navigator.pushReplacementNamed(context, '/home'); // Navigate to HomePage
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Remove the loading indicator
      displayMessageToUser(
          e.code, context); // Display the error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),
              const Text(
                "AUTH NOTE",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 25),
              TextFieldInput(
                  hintText: "Enter your email",
                  controller: _emailController,
                  obscureText: false),
              const SizedBox(height: 25),
              TextFieldInput(
                  hintText: "Enter your password",
                  controller: _passwordController,
                  obscureText: true),
              const SizedBox(height: 25),
              MyButton(text: "Login", onTap: () => loginUser(context)),
              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot password?"),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
