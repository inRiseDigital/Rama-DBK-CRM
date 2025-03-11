import 'package:flutter/material.dart';

class StockHeroComponent extends StatelessWidget {
  const StockHeroComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    final bool isSmallScreen = screenSize.width < 360;

    return Stack(
      children: [
        // Background Image with SafeArea
        Container(
          height: isMobile ? screenSize.height * 0.4 : screenSize.height * 0.9,
          width: double.infinity,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/vehicle_group.png'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
        // Dark Overlay with gradient for better readability
        Container(
          height: isMobile ? screenSize.height * 0.4 : screenSize.height * 0.9,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        // Content with SafeArea
        SafeArea(
          child: Container(
            height:
                isMobile ? screenSize.height * 0.4 : screenSize.height * 0.9,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16.0 : 80.0,
              vertical: isMobile ? 16.0 : 100.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isMobile) SizedBox(height: isSmallScreen ? 8.0 : 20.0),
                Text(
                  isMobile
                      ? 'Find Your Perfect Vehicle'
                      : 'Driven by Excellence,\nTrusted Worldwide',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 24.0 : (isMobile ? 28.0 : 50.0),
                    letterSpacing: 0.5,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: isMobile ? 8.0 : 24.0),
                if (!isMobile)
                  Text(
                    'RamaDBK is a premier vehicle exporter, bringing high-quality automobiles to customers worldwide with trust and efficiency.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: isSmallScreen ? 14.0 : (isMobile ? 15.0 : 18.0),
                      height: 1.4,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
