import 'package:flutter/material.dart';

/// Hero Section for Spare Parts Page
/// Showcases a large background image with an overlay,
/// plus prominent text and buttons for calls to action.
class SparePartsHeroComponent extends StatelessWidget {
  const SparePartsHeroComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;

    // Additional breakpoints for more refined responsiveness
    final bool isMobile = screenSize < 600; // small mobile
    final bool isTablet = screenSize >= 600 && screenSize < 1024; // tablets
    final bool isDesktop = screenSize >= 1024; // desktop

    // We'll decide height based on device type
    final double containerHeight =
        isMobile
            ? 400
            : isTablet
            ? 500
            : 600;

    return Stack(
      children: [
        // Background Image
        Container(
          height: containerHeight,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/car_02.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Dark Overlay for readability (slightly more subtle)
        Container(
          height: containerHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black54, Colors.black87],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // Foreground Content
        SizedBox(
          height: containerHeight,
          width: double.infinity,
          child: Padding(
            // Adjust side paddings for each device type
            padding: EdgeInsets.symmetric(
              horizontal:
                  isMobile
                      ? 20
                      : isTablet
                      ? 60
                      : 80,
              vertical:
                  isMobile
                      ? 40
                      : isTablet
                      ? 60
                      : 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // MAIN TITLE
                Text(
                  'Driven by Excellence, Trusted Worldwide',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize:
                        isMobile
                            ? 28
                            : isTablet
                            ? 36
                            : 48,
                    letterSpacing: 0.5,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),

                // SUBTEXT
                Text(
                  'RamaDBK is a premier vehicle exporter, bringing high-quality automobiles '
                  'and spare parts to customers worldwide with trust and efficiency.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize:
                        isMobile
                            ? 14
                            : isTablet
                            ? 16
                            : 18,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 24),

                // ACTION BUTTONS (Explore & Contact)
                Row(
                  children: [
                    _buildActionButton(
                      text: 'Explore Parts',
                      color: Colors.red,
                      icon: Icons.search,
                      onPressed: () {
                        // TODO: Navigate to Spare Parts section or search
                      },
                    ),
                    const SizedBox(width: 12),
                    _buildActionButton(
                      text: 'Contact Us',
                      color: Colors.white,
                      icon: Icons.email,
                      onPressed: () {
                        // TODO: Open contact page or send message
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Reusable Action Button
  Widget _buildActionButton({
    required String text,
    required Color color,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    final bool isPrimary = color == Colors.red;

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 20,
        color: isPrimary ? Colors.white : Colors.black87,
      ),
      label: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: isPrimary ? Colors.white : Colors.black87,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation:
            isPrimary ? 4 : 0, // a slight elevation for the primary button
      ),
    );
  }
}
