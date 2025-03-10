import 'package:flutter/material.dart';

class StockHeroComponent extends StatelessWidget {
  const StockHeroComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;

    return Stack(
      children: [
        // Background Image
        Container(
          height: isMobile ? screenSize.height * 0.9 : screenSize.height * 1,
          width: double.infinity,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/vehicle_group.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Dark Overlay for readability
        Container(
          height: isMobile ? screenSize.height * 0.9 : screenSize.height * 1,
          width: double.infinity,
          color: Colors.black.withOpacity(0.5),
        ),
        // Content
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20.0 : 80.0,
            vertical: isMobile ? 40.0 : 100.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: isMobile ? 12.0 : 20.0),
              Text(
                'Driven by Excellence, Trusted Worldwide',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 34.0 : 50.0,
                  letterSpacing: 0.5,
                  height: 1.1,
                ),
              ),
              SizedBox(height: isMobile ? 16.0 : 24.0),
              Text(
                'RamaDBK is a premier vehicle exporter, bringing high-quality automobiles to customers worldwide with trust and efficiency.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: isMobile ? 16.0 : 18.0,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
