import 'package:flutter/material.dart';

/// About Section Component
///
/// Displays company information with a responsive layout that changes
/// based on screen size. Includes company history, key features,
/// and a call-to-action button.

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      color: Colors.white,
      child:
          isMobile
              ? Column(
                children: [
                  // About Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _buildAboutContent(),
                  ),
                  const SizedBox(height: 30.0),
                  // About Image
                  Container(
                    height: 300.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/car_02.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              )
              : Row(
                children: [
                  // About Text
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      child: _buildAboutContent(),
                    ),
                  ),

                  // About Image
                  Expanded(
                    child: Container(
                      height: 450.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/car_02.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildAboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ABOUT US',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 36.0,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Premium Vehicle Dealership Since 1995',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Color.fromARGB(255, 112, 110, 110),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(width: 50.0, height: 3.0, color: Colors.red),
        const SizedBox(height: 20.0),
        Text(
          'RamaDBK is a renowned name in the automotive industry, specializing in premium and luxury vehicles. With over 25 years of experience, we have established ourselves as leaders in providing exceptional vehicles and outstanding customer service.',
          style: TextStyle(
            fontSize: 16.0,
            height: 1.6,
            color: const Color.fromRGBO(97, 97, 97, 1),
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: _buildAboutFeature(
                Icons.check_circle,
                'Premium Selection',
                'Hand-picked luxury vehicles',
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: _buildAboutFeature(
                Icons.check_circle,
                'Expert Team',
                'Knowledgeable professionals',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: _buildAboutFeature(
                Icons.check_circle,
                'Quality Assurance',
                'Rigorous inspection process',
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: _buildAboutFeature(
                Icons.check_circle,
                'Customer Satisfaction',
                'Award-winning service',
              ),
            ),
          ],
        ),
        const SizedBox(height: 30.0),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 15.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: const Text(
            'Learn More About Us',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutFeature(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.red, size: 20.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title in red color
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                description,
                style: TextStyle(color: Colors.grey[600], fontSize: 14.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
