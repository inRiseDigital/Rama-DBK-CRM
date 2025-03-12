import 'package:flutter/material.dart';
import 'package:rama_dbk_crm/screens/serviceScreen.dart';
import 'package:rama_dbk_crm/screens/sparePartsScreen.dart';
import 'package:rama_dbk_crm/screens/stockScreen.dart';
import 'homeScreen.dart';
import 'aboutScreen.dart';
import 'contactScreen.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  static const double _navbarHeight = 80;

  final List<Widget> _screens = [
    const HomeScreen(),
    const StockScreen(),
    const SparePartsScreen(),
    const ServiceScreen(),
    const AboutScreen(), // Index 4 for About Us
    const ContactScreen(), // Index 5 for Contacts
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Screen content area + footer
          Positioned.fill(
            top: _navbarHeight,
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
          // NavBar persists across all screens and stays on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              selectedIndex: _currentIndex,
              onItemSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              onDropdownItemSelected: (route) {
                // Handle dropdown item selection
                print('Selected route: $route');
                // TODO: Implement navigation to the selected route
              },
            ),
          ),
        ],
      ),
    );
  }
}
