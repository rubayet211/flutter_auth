import 'package:auth_demo/auth/login_or_register.dart';
import 'package:auth_demo/firebase_options.dart';
import 'package:auth_demo/pages/home_page.dart';
import 'package:auth_demo/pages/login_page.dart';
import 'package:auth_demo/pages/register_page.dart';
import 'package:auth_demo/theme/dark_mode.dart';
import 'package:auth_demo/theme/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      home: LoginOrRegister(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
