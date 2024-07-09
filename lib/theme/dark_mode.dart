import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.teal.shade900,
    primary: Colors.teal.shade800,
    secondary: Colors.teal.shade700,
    onPrimary: Colors.teal.shade300,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Colors.teal[300],
        displayColor: Colors.white,
      ),
);
