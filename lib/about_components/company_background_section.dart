import 'package:flutter/material.dart';

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
  final Map<String, bool> _isHovering = {};

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

  Widget _buildTitleSection() {
    return Column(
      children: [
        Text(
          "Company Background",
          style: TextStyle(
            fontSize: 56,
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

  Widget _buildInfoCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth =
            constraints.maxWidth > 700 ? 320 : constraints.maxWidth * 0.9;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFlexibleCard(
              title: "Who We Are",
              description:
                  "RamDBK is a well-established vehicle exporter in Japan, supplying automobiles and auto parts to overseas markets.",
              icon: Icons.business,
              width: cardWidth,
            ),
            const SizedBox(width: 20),
            _buildFlexibleCard(
              title: "What We Do",
              description:
                  "We deal with a variety of vehicles from Japanese auctions and dealers, handling export logistics efficiently.",
              icon: Icons.directions_car,
              width: cardWidth,
            ),
          ],
        );
      },
    );
  }

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
        LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth =
                constraints.maxWidth > 800 ? 250 : constraints.maxWidth * 0.4;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFlexibleCard(
                  title: "Customer Satisfaction",
                  description:
                      "Customer satisfaction is at the heart of our operations. We aim to deliver top-notch vehicles and outstanding service.",
                  icon: Icons.thumb_up,
                  width: cardWidth,
                ),
                const SizedBox(width: 20),
                _buildFlexibleCard(
                  title: "Transparency & Trust",
                  description:
                      "We prioritize honesty and transparency, ensuring all vehicle transactions are fair and straightforward.",
                  icon: Icons.verified_user,
                  width: cardWidth,
                ),
                const SizedBox(width: 20),
                _buildFlexibleCard(
                  title: "Global Reach",
                  description:
                      "With a strong international presence, we efficiently deliver vehicles to clients worldwide.",
                  icon: Icons.public,
                  width: cardWidth,
                ),
                const SizedBox(width: 20),
                _buildFlexibleCard(
                  title: "Commitment to Quality",
                  description:
                      "Every vehicle we export is thoroughly inspected to maintain high standards of reliability.",
                  icon: Icons.star,
                  width: cardWidth,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildFlexibleCard({
    required String title,
    required String description,
    required IconData icon,
    required double width,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering[title] = true),
      onExit: (_) => setState(() => _isHovering[title] = false),
      child: IntrinsicHeight(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color:
                    _isHovering[title] == true
                        ? Colors.black26
                        : Colors.black12,
                blurRadius: _isHovering[title] == true ? 15 : 10,
                offset: Offset(0, _isHovering[title] == true ? 8 : 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform:
                    _isHovering[title] == true
                        ? Matrix4.translationValues(0, -2, 0)
                        : Matrix4.translationValues(0, 0, 0),
                child: Icon(
                  icon,
                  size: 40,
                  color:
                      _isHovering[title] == true
                          ? Colors.redAccent
                          : Colors.red,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      _isHovering[title] == true
                          ? Colors.black
                          : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
