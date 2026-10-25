import 'package:flutter/material.dart';

abstract final class Jazam {
  static const pink = Color(0xFFFF2D55);
  static const ink = Color(0xFF1E2432);
  static const muted = Color(0xFFA3ABC2);
  static const background = Color(0xFFF6F7F9);
  static const field = Color(0xFFF1F2F6);
  static const mint = Color(0xFF48DFBD);
  static const purple = Color(0xFF6050DF);
  static const orange = Color(0xFFFF9300);
  static const blue = Color(0xFF50C6F3);
  static const radius = BorderRadius.all(Radius.circular(9));

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: pink, primary: pink, surface: Colors.white),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Arial',
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 15, height: 1.4, color: ink),
      bodyLarge: TextStyle(fontSize: 17, color: ink),
      titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: ink),
      titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: ink),
    ),
    dividerColor: const Color(0xFFECEEF2),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, surfaceTintColor: Colors.transparent, centerTitle: true, elevation: 0, titleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: ink)),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: field, hintStyle: const TextStyle(color: muted),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
    ),
    filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(
      backgroundColor: pink, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 46),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    )),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: pink)),
  );
}
