import 'package:flutter/material.dart';

/// Services Section Component
///
/// Displays the company's services in a responsive card layout.
/// Each service includes an icon, topic, title, description, and a call-to-action link.
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    fontSize: isMobile ? 24.0 : 36.0,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'What We Offer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 24.0 : 32.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(width: 50.0, height: 3.0, color: Colors.red),
                const SizedBox(height: 40.0),
              ],
            ),
          ),

          // Responsive Services Grid using Wrap
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              HoverServiceCard(
                icon: Icons.directions_car,
                topic: 'Automotive',
                title: 'Vehicle Sales',
                description:
                    'Explore our extensive collection of premium new and pre-owned vehicles.',
                isMobile: isMobile,
              ),
              HoverServiceCard(
                icon: Icons.attach_money,
                topic: 'Financing',
                title: 'Financing Options',
                description:
                    'Flexible financing solutions tailored to your budget and needs.',
                isMobile: isMobile,
              ),
              HoverServiceCard(
                icon: Icons.build,
                topic: 'Service',
                title: 'Maintenance & Service',
                description:
                    'Professional maintenance and repair services by certified technicians.',
                isMobile: isMobile,
              ),
              HoverServiceCard(
                icon: Icons.handshake,
                topic: 'Trade-In',
                title: 'Trade-In Program',
                description:
                    'Fair and competitive trade-in values for your current vehicle.',
                isMobile: isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A service card widget that adds a hover effect on web/desktop.
class HoverServiceCard extends StatefulWidget {
  final IconData icon;
  final String topic;
  final String title;
  final String description;
  final bool isMobile;

  const HoverServiceCard({
    Key? key,
    required this.icon,
    required this.topic,
    required this.title,
    required this.description,
    required this.isMobile,
  }) : super(key: key);

  @override
  _HoverServiceCardState createState() => _HoverServiceCardState();
}

class _HoverServiceCardState extends State<HoverServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Force card width to be the same across all devices:
    // If 90% of the screen width is less than 300, use that; otherwise, use 300.
    final double cardWidth =
        MediaQuery.of(context).size.width * 0.9 < 300.0
            ? MediaQuery.of(context).size.width * 0.9
            : 300.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform:
            _isHovered ? (Matrix4.identity()..scale(1.03)) : Matrix4.identity(),
        width: cardWidth,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.2 : 0.1),
              blurRadius: _isHovered ? 25.0 : 20.0,
              offset: Offset(0, _isHovered ? 8 : 5),
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
              child: Icon(widget.icon, color: Colors.red, size: 30.0),
            ),
            const SizedBox(height: 20.0),
            // Topic Text
            Text(
              widget.topic,
              style: TextStyle(
                color: Colors.red,
                fontSize: widget.isMobile ? 16.0 : 22.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              widget.description,
              style: TextStyle(
                color: Colors.grey[600],
                height: 1.5,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Learn More',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Icon(Icons.arrow_forward, color: Colors.red, size: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
