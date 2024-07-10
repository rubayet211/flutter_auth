import 'package:auth_demo/auth/login_or_register.dart';
import 'package:auth_demo/model/note_provider.dart';
import 'package:auth_demo/model/user_provider.dart';
import 'package:auth_demo/services/NoteService.dart';
import 'package:auth_demo/services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'theme/dark_mode.dart';
import 'theme/light_mode.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NoteProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/loginOrRegister',
        routes: {
          '/loginOrRegister': (context) => const LoginOrRegister(),
          '/home': (context) => const HomePage(),
        },
        theme: lightMode,
        darkTheme: darkMode,
      ),
    );
  }
}
