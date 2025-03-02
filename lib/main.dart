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
        primaryColor: const Color(0xFF3F51B5), // Indigo as primary color
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3F51B5),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}