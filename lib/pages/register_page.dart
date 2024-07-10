import 'package:auth_demo/components/my_button.dart';
import 'package:auth_demo/components/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "AUTH NOTE",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFieldInput(
                    hintText: "Enter your username",
                    controller: _usernameController,
                    obscureText: false),
                const SizedBox(
                  height: 25,
                ),
                TextFieldInput(
                    hintText: "Enter your email",
                    controller: _emailController,
                    obscureText: false),
                const SizedBox(
                  height: 25,
                ),
                TextFieldInput(
                    hintText: "Enter your password",
                    controller: _passwordController,
                    obscureText: true),
                const SizedBox(
                  height: 25,
                ),
                TextFieldInput(
                    hintText: "Confirm your password",
                    controller: _confirmPasswordController,
                    obscureText: true),
                const SizedBox(
                  height: 25,
                ),
                MyButton(text: "Register", onTap: onTap),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        "Login",
                        style: TextStyle(
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
