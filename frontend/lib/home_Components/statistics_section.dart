import 'package:flutter/material.dart';

/// Statistics Section Component
///
/// Displays key company statistics in a responsive layout with a visually
/// appealing background. Highlights years of experience, customer count,
/// inventory size, and industry recognition.

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: const AssetImage('assets/images/car_03.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.8),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        children: [
          isMobile
              ? Column(
                  children: [
                    _buildStatItem('25+', 'Years of Experience'),
                    const SizedBox(height: 30.0),
                    _buildStatItem('5000+', 'Happy Customers'),
                    const SizedBox(height: 30.0),
                    _buildStatItem('500+', 'Premium Vehicles'),
                    const SizedBox(height: 30.0),
                    _buildStatItem('15+', 'Industry Awards'),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem('25+', 'Years of Experience'),
                    _buildStatItem('5000+', 'Happy Customers'),
                    _buildStatItem('500+', 'Premium Vehicles'),
                    _buildStatItem('15+', 'Industry Awards'),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 36.0,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}