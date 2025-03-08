import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CompanyBackgroundSection extends StatefulWidget {
  const CompanyBackgroundSection({Key? key}) : super(key: key);

  @override
  _CompanyBackgroundSectionState createState() =>
      _CompanyBackgroundSectionState();
}

class _CompanyBackgroundSectionState extends State<CompanyBackgroundSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeInAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitleSection(),
            const SizedBox(height: 30),
            _buildInfoCards(),
            const SizedBox(height: 40),
            _buildPhilosophySection(),
          ],
        ),
      ),
    );
  }

  /// Title Section
  Widget _buildTitleSection() {
    return Column(
      children: [
        Text(
          "Company Background",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Container(width: 60, height: 4, color: Colors.red),
        const SizedBox(height: 12),
        Text(
          "A Pioneer in Japanese Vehicle Export",
          style: TextStyle(fontSize: 18, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Cards Section (Who We Are, What We Do)
  Widget _buildInfoCards() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: [
        _buildHoverCard(
          title: "Who We Are",
          description:
              "RamDBK is a well-established vehicle exporter in Japan, supplying automobiles and auto parts to overseas markets. "
              "With over 25 years in business and a team of experts, we provide high-quality vehicles to a global audience.",
          icon: Icons.business,
        ),
        _buildHoverCard(
          title: "What We Do",
          description:
              "We deal with a variety of vehicles from Japanese auctions and dealers, handling export logistics efficiently. "
              "Our goal is to maximize customer value by ensuring quality and affordability in all transactions.",
          icon: Icons.directions_car,
        ),
      ],
    );
  }

  /// Business Philosophy Section
  Widget _buildPhilosophySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Our Business Philosophy",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            _buildPhilosophyCard(
              title: "Customer Satisfaction",
              description:
                  "Customer satisfaction is at the heart of our operations. We aim to deliver top-notch vehicles and outstanding service.",
              icon: Icons.thumb_up,
            ),
            _buildPhilosophyCard(
              title: "Transparency & Trust",
              description:
                  "We prioritize honesty and transparency, ensuring all vehicle transactions are fair and straightforward.",
              icon: Icons.verified_user,
            ),
            _buildPhilosophyCard(
              title: "Global Reach",
              description:
                  "With a strong international presence, we efficiently deliver vehicles to clients worldwide.",
              icon: Icons.public,
            ),
            _buildPhilosophyCard(
              title: "Commitment to Quality",
              description:
                  "Every vehicle we export is thoroughly inspected to maintain high standards of reliability.",
              icon: Icons.star,
            ),
          ],
        ),
      ],
    );
  }

  /// Hover Effect Card
  Widget _buildHoverCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 320,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.red),
            const SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  /// Business Philosophy Card
  Widget _buildPhilosophyCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
