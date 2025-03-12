import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Padding(
      // Instead of a Container with a hard-coded color, we use simple Padding
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              const Text(
                'ABOUT US',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 36.0,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 10.0),

              // Subtitle
              const Text(
                'Premium Vehicle Dealership Since 1995',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 112, 110, 110),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(width: 50.0, height: 3.0, color: Colors.red),
              const SizedBox(height: 20.0),

              // Paragraph
              const Text(
                'RamaDBK is a renowned name in the automotive industry, specializing in premium and luxury vehicles. With over 25 years of experience, we have established ourselves as leaders in providing exceptional vehicles and outstanding customer service.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.6,
                  color: Color.fromRGBO(97, 97, 97, 1),
                ),
              ),
              const SizedBox(height: 30.0),

              // Row 1 of features
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildCenteredFeature(
                      Icons.check_circle,
                      'Premium Selection',
                      'Hand-picked luxury vehicles',
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: _buildCenteredFeature(
                      Icons.check_circle,
                      'Expert Team',
                      'Knowledgeable professionals',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              // Row 2 of features
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildCenteredFeature(
                      Icons.check_circle,
                      'Quality Assurance',
                      'Rigorous inspection process',
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: _buildCenteredFeature(
                      Icons.check_circle,
                      'Customer Satisfaction',
                      'Award-winning service',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// A fully centered feature: icon on top, then title, then description.
  Widget _buildCenteredFeature(
    IconData icon,
    String title,
    String description,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.red, size: 24.0),
        const SizedBox(height: 10.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
        ),
      ],
    );
  }
}
