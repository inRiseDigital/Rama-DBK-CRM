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
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Our Legacy of Excellence",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.1,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "A Pioneer in Japanese Vehicle Export Since 1988",
            style: TextStyle(fontSize: 18, color: Colors.black54, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth =
            constraints.maxWidth > 700 ? 320 : constraints.maxWidth * 0.9;

        return Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            _buildFlexibleCard(
              title: "Who We Are",
              description:
                  "RamaDBK is a leading Japanese vehicle exporter with over 35 years of experience, known for our commitment to quality and customer satisfaction. We specialize in exporting premium Japanese vehicles to clients worldwide.",
              icon: Icons.business,
              width: cardWidth,
            ),
            _buildFlexibleCard(
              title: "What We Do",
              description:
                  "We provide comprehensive vehicle export services, including procurement from Japanese auctions, quality inspection, documentation handling, and efficient shipping logistics. Our digital platform makes the process seamless for our global customers.",
              icon: Icons.directions_car,
              width: cardWidth,
            ),
            _buildFlexibleCard(
              title: "Our Reach",
              description:
                  "With a strong presence in major markets worldwide and strategic partnerships across continents, we deliver vehicles to customers in over 50 countries, maintaining our reputation for reliability and excellence.",
              icon: Icons.public,
              width: cardWidth,
            ),
          ],
        );
      },
    );
  }

  Widget _buildPhilosophySection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Our Core Values",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            double cardWidth =
                constraints.maxWidth > 800 ? 250 : constraints.maxWidth * 0.4;
            bool isMobile = constraints.maxWidth <= 800;

            return Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildFlexibleCard(
                  title: "Customer First",
                  description:
                      "We prioritize customer satisfaction through personalized service and transparent communication throughout the export process.",
                  icon: Icons.thumb_up,
                  width: isMobile ? constraints.maxWidth * 0.9 : cardWidth,
                ),
                _buildFlexibleCard(
                  title: "Quality Assurance",
                  description:
                      "Every vehicle undergoes thorough inspection and quality checks before export, ensuring you receive only the best.",
                  icon: Icons.verified_user,
                  width: isMobile ? constraints.maxWidth * 0.9 : cardWidth,
                ),
                _buildFlexibleCard(
                  title: "Global Standards",
                  description:
                      "We maintain high international standards in our operations, complying with global automotive regulations and export requirements.",
                  icon: Icons.public,
                  width: isMobile ? constraints.maxWidth * 0.9 : cardWidth,
                ),
                _buildFlexibleCard(
                  title: "Innovation",
                  description:
                      "Our digital platform and modern processes ensure efficient, hassle-free vehicle procurement and export services.",
                  icon: Icons.lightbulb,
                  width: isMobile ? constraints.maxWidth * 0.9 : cardWidth,
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
                color: _isHovering[title] == true
                    ? Colors.black26
                    : Colors.black12,
                blurRadius: _isHovering[title] == true ? 15 : 10,
                offset: Offset(0, _isHovering[title] == true ? 8 : 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: _isHovering[title] == true
                    ? Matrix4.translationValues(0, -2, 0)
                    : Matrix4.translationValues(0, 0, 0),
                child: Icon(
                  icon,
                  size: 40,
                  color: _isHovering[title] == true
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
                  color: _isHovering[title] == true
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
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
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
