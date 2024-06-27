import 'package:flutter/material.dart';

class AppThemeDark {
  static ThemeData themeData = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    colorScheme: const ColorScheme.dark(
      primary: Colors.blue,
      secondary: Color.fromARGB(255, 81, 136, 99),
      surface: Colors.blueGrey,
      onPrimary: Color.fromARGB(255, 62, 78, 87),
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.blueGrey[900],
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      centerTitle: true,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      headlineLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    listTileTheme: ListTileThemeData(
        tileColor: Colors.blueGrey[800], selectedColor: Colors.amber),
    cardTheme: CardTheme(
      color: Colors.blueGrey[800],
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade600, width: 1),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
