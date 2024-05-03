import 'package:flutter/material.dart';

class AppTheme {
  static const Color facebookIconColor = Color(0xFF0866FF);
  static const Color googleIconColor = Color(0xFFDC3C2A);
  static const Color whatsappIconColor = Color(0xFF11ba17);
}

enum AppThemee {
  blueLight("Blue Light"),
  blueDark("Blue Dark"),
  redDark("Red Dark");

  const AppThemee(this.name);
  final String name;
}

final appThemeData = {
  AppThemee.blueLight: ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Colors.purple),
    ),
  ),
  AppThemee.blueDark: ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
  ),
  AppThemee.redDark: ThemeData(
    useMaterial3: false,
    appBarTheme: AppBarTheme(backgroundColor: Colors.red[700]),
    brightness: Brightness.dark,
    primaryColor: Colors.red[700],
  ),
};
