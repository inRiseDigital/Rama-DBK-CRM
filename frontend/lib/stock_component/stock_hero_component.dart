import 'package:flutter/material.dart';

class StockHeroComponent extends StatelessWidget {
  const StockHeroComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: isMobile ? 36 : 48,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2D3748), Color(0xFF1A202C)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFF2D55).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Vehicle Inventory',
              style: TextStyle(
                color: Color(0xFFFF2D55),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 20 : 24),
          Text(
            'Find Your Perfect\nVehicle Today',
            style: TextStyle(
              fontSize: isMobile ? 36 : 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 800,
            ),
            child: const Text(
              'Explore our extensive collection of premium vehicles. From luxury cars to reliable commercial vehicles, find exactly what you need.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
