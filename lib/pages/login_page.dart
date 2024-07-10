import 'package:auth_demo/components/my_button.dart';
import 'package:auth_demo/components/text_field_input.dart';
import 'package:auth_demo/model/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  void loginUser(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      await userProvider.signIn(
          _emailController.text, _passwordController.text);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
