import 'package:flutter/material.dart';

class MyTextTheme {
  static const TextStyle textTheme = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextTheme get textThemes {
    return const TextTheme(
      displayLarge: textTheme,
    );
  }
}
