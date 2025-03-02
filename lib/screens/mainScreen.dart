import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import 'homeScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text('About Screen')),
    const Center(child: Text('Services Screen')),
    const Center(child: Text('Contact Screen')),
    const Center(child: Text('Login Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Static navbar that persists across screens
          NavBar(
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          // Content area that changes based on navigation
          Expanded(
            child: _screens[_currentIndex],
          ),
        ],
      ),
    );
  }
}