import 'package:flutter/material.dart';
import 'screens/mainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rama CRM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF2D55), // Bright red
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF2D55),
          brightness: Brightness.dark, // Dark theme to match background
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
        // Text theme for better readability on dark background
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
