import 'package:flutter/material.dart';

class MyThemeData {
  static const Color DarkPrimary = Colors.blue;
  static bool is_Dark = true;
  static ThemeData lightTheme = ThemeData(
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        titleMedium: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.blue),
        bodyMedium: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.blue),
      ),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff5D9CEC),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
      ),
      scaffoldBackgroundColor:Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff141922),
        onPrimary: Colors.white,
        onSecondary: DarkPrimary,
        background:  Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIconTheme: IconThemeData(size: 32),
        selectedItemColor: Colors.blue,

      ),

      cardTheme: CardTheme(
          color: Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)))

  );
  static ThemeData DarkTheme = ThemeData(
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(
            fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white),
        bodyMedium: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.blue),
        bodySmall: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
      ),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff5D9CEC),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 30),
      ),
      scaffoldBackgroundColor:Colors.black12,

    colorScheme: ColorScheme.fromSeed(
        seedColor: DarkPrimary,
        primary: DarkPrimary,
        secondary: DarkPrimary,
        onPrimary: Colors.white,
        background: Color(0xff141922),
      ),
      primaryColor: DarkPrimary,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIconTheme: IconThemeData(size: 32),
        unselectedIconTheme: IconThemeData(color: Colors.white)
      ),

    );
}
