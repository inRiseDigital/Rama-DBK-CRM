import 'package:flutter/material.dart';
import 'package:rama_dbk_crm/screens/serviceScreen.dart';
import 'package:rama_dbk_crm/screens/sparePartsScreen.dart';
import 'package:rama_dbk_crm/screens/stockScreen.dart';
import 'homeScreen.dart';
import 'aboutScreen.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const StockScreen(),
    const SparePartsScreen(),
    const ServiceScreen(),
    const AboutScreen(), // Index 4 for About Us
    const Center(child: Text('Contact Screen')), // Index 5 for Contacts
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // NavBar persists across all screens
          NavBar(
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          // Screen content area + footer
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Show the selected screen based on _currentIndex
                  _screens[_currentIndex],
                  // Footer persists across all screens
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
