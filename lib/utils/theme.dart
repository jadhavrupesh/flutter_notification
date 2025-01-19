import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  static const Color black = Color(0xFF000000);
  static const Color deepRed = Color(0xFFD10028);
  static const Color darkRed = Color(0xFFB7022D);
  static const Color brightOrange = Color(0xFFFFA91A);
  static const Color burntOrange = Color(0xFFEF7816);
  static const Color goldenOrange = Color(0xFFF79219);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color darkGrey = Color(0xFF616161);
  static const Color white = Color(0xFFFFFFFF);
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.deepRed,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.deepRed,
    secondary: AppColors.brightOrange,
    background: AppColors.black,
    error: AppColors.darkRed,
  ),
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.deepRed,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(color: AppColors.darkGrey),
    titleTextStyle: const TextStyle(
      color: AppColors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: AppColors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: AppColors.darkGrey,
    ),
  ),
  cardTheme: CardTheme(
    color: AppColors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.lightGrey.withOpacity(0.1),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    prefixIconColor: AppColors.darkGrey,
    suffixIconColor: AppColors.darkGrey,
    hintStyle: TextStyle(
      color: AppColors.darkGrey.withOpacity(0.5),
      fontSize: 14,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.deepRed,
      foregroundColor: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.darkGrey,
    size: 24,
  ),
  dividerTheme: const DividerThemeData(
    color: AppColors.lightGrey,
    thickness: 1,
    space: 24,
  ),
);
