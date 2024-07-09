import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.teal.shade300,
    primary: Colors.teal.shade200,
    secondary: Colors.teal.shade400,
    inversePrimary: Colors.teal.shade800,
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.teal[800],
        displayColor: Colors.black,
      ),
);
