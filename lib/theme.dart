import 'package:flutter/material.dart';

final ThemeData customTheme = ThemeData(
  primaryColor: Color(0xFF2E3C3C),
  // Peach
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Roboto', // Replace with your font
      fontSize: 72,
      color: Color(0xFFF4EDE4), // Light peach
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Roboto', // Replace with your font
      fontSize: 16,
      color: Color(0xFF2E3C3C), // Dark teal
    ),
  ),
  iconTheme: IconThemeData(
    color: Color(0xFFF4A261), // Orange
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Color(0xFFF4A261))
      .copyWith(background: Color(0xFFF4EDE4)),
);
