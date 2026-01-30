import 'package:flutter/material.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF2E5AAC), // blue
      secondary: Color.fromARGB(255, 243, 207, 6), // yellow
      surface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 250, 218, 39),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Color(0xFFF3D008),
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(size: 28),
      unselectedIconTheme: IconThemeData(size: 20),
      selectedLabelStyle: TextStyle(fontSize: 16),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      type: BottomNavigationBarType.fixed,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFFF3D008), // yellow
      secondary: const Color(0xFF2E5AAC), // blue
      surface: const Color(0xFF0A0A0A),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 250, 246, 39),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Color.fromARGB(255, 250, 246, 39),
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(size: 28),
      unselectedIconTheme: IconThemeData(size: 20),
      selectedLabelStyle: TextStyle(fontSize: 16),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      type: BottomNavigationBarType.fixed,
    ),
  );
}

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
