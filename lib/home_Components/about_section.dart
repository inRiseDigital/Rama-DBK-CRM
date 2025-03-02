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
      padding: EdgeInsets.symmetric(
        vertical: 60.0,
      ),
      color: Colors.grey[100],
      child: isMobile
          ? Column(
              children: [
                // About Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: _buildAboutContent(),
                ),
                SizedBox(height: 30.0),
                // About Image
                Container(
                  height: 300.0,
                  decoration: BoxDecoration(
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
                    padding: EdgeInsets.symmetric(horizontal: 60.0),
                    child: _buildAboutContent(),
                  ),
                ),
                
                // About Image
                Expanded(
                  child: Container(
                    height: 450.0,
                    decoration: BoxDecoration(
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
        Text(
          'ABOUT US',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            letterSpacing: 2.0,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Premium Vehicle Dealership Since 1995',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          width: 50.0,
          height: 3.0,
          color: Colors.red,
        ),
        SizedBox(height: 20.0),
        Text(
          'RamaDBK is a renowned name in the automotive industry, specializing in premium and luxury vehicles. With over 25 years of experience, we have established ourselves as leaders in providing exceptional vehicles and outstanding customer service.',
          style: TextStyle(
            fontSize: 16.0,
            height: 1.6,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: _buildAboutFeature(
                Icons.check_circle,
                'Premium Selection',
                'Hand-picked luxury vehicles',
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: _buildAboutFeature(
                Icons.check_circle,
                'Expert Team',
                'Knowledgeable professionals',
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(
              child: _buildAboutFeature(
                Icons.check_circle,
                'Quality Assurance',
                'Rigorous inspection process',
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: _buildAboutFeature(
                Icons.check_circle,
                'Customer Satisfaction',
                'Award-winning service',
              ),
            ),
          ],
        ),
        SizedBox(height: 30.0),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 15.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Text(
            'Learn More About Us',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutFeature(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.red,
          size: 20.0,
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}