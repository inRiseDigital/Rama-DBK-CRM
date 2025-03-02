import 'package:flutter/material.dart';

/// Services Section Component
///
/// Displays the company's services in a responsive card layout.
/// Each service includes an icon, title, description, and a call-to-action link.

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60.0,
        horizontal: isMobile ? 20.0 : 60.0,
      ),
      child: Column(
        children: [
          // Section Title
          Center(
            child: Column(
              children: [
                Text(
                  'OUR SERVICES',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'What We Offer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 24.0 : 32.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: 50.0,
                  height: 3.0,
                  color: Colors.red,
                ),
                SizedBox(height: 40.0),
              ],
            ),
          ),
          
          // Services Grid
          isMobile
              ? Column(
                  children: [
                    _buildServiceCard(
                      Icons.directions_car,
                      'Vehicle Sales',
                      'Explore our extensive collection of premium new and pre-owned vehicles.',
                    ),
                    SizedBox(height: 20.0),
                    _buildServiceCard(
                      Icons.attach_money,
                      'Financing Options',
                      'Flexible financing solutions tailored to your budget and needs.',
                    ),
                    SizedBox(height: 20.0),
                    _buildServiceCard(
                      Icons.build,
                      'Maintenance & Service',
                      'Professional maintenance and repair services by certified technicians.',
                    ),
                    SizedBox(height: 20.0),
                    _buildServiceCard(
                      Icons.handshake,
                      'Trade-In Program',
                      'Fair and competitive trade-in values for your current vehicle.',
                    ),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildServiceCard(
                            Icons.directions_car,
                            'Vehicle Sales',
                            'Explore our extensive collection of premium new and pre-owned vehicles.',
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: _buildServiceCard(
                            Icons.attach_money,
                            'Financing Options',
                            'Flexible financing solutions tailored to your budget and needs.',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildServiceCard(
                            Icons.build,
                            'Maintenance & Service',
                            'Professional maintenance and repair services by certified technicians.',
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: _buildServiceCard(
                            Icons.handshake,
                            'Trade-In Program',
                            'Fair and competitive trade-in values for your current vehicle.',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Icon(
              icon,
              color: Colors.red,
              size: 30.0,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[600],
              height: 1.5,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 20.0),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Learn More',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5.0),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.red,
                  size: 16.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}