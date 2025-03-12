import 'package:flutter/material.dart';

class ManagementMessage extends StatefulWidget {
  const ManagementMessage({Key? key}) : super(key: key);

  @override
  _ManagementMessageState createState() => _ManagementMessageState();
}

class _ManagementMessageState extends State<ManagementMessage>
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
            _buildMessageCard(),
            const SizedBox(height: 40),
            _buildLeadershipRoles(),
          ],
        ),
      ),
    );
  }

  /// Title Section
  Widget _buildTitleSection() {
    return Column(
      children: [
        const Text(
          "Message from the Management",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Container(width: 60, height: 4, color: Colors.red),
        const SizedBox(height: 12),
        const Text(
          "Guiding RamaDBK Towards Global Excellence",
          style: TextStyle(fontSize: 18, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Main Message Card
  Widget _buildMessageCard() {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
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
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/president.jpg', // Make sure to add this image
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Message from the President",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              "Dear Valued Partners and Customers,",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Since our establishment in 1988, RamaDBK has been committed to excellence in the automotive export industry. "
              "What began as a vision to bridge the gap between Japanese quality vehicles and global markets has grown into "
              "a trusted enterprise serving customers in over 50 countries.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text(
              "Our success story is built on three fundamental principles: unwavering commitment to quality, "
              "transparent business practices, and exceptional customer service. These principles continue to guide "
              "us as we embrace new technologies and expand our global presence.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text(
              "Thank you for your trust in RamaDBK. We look forward to serving you and contributing to your success.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "Jagath C. Ramanayake",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Text(
              "President & CEO",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  /// Leadership Roles Section
  Widget _buildLeadershipRoles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Leadership & Industry Recognition",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 768;
            return Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildRoleCard(
                  title: "President of SLBCJ",
                  description:
                      "Leading the Sri Lanka Business Council in Japan to strengthen bilateral business relationships and promote trade opportunities.",
                  icon: Icons.business_center,
                  width: isMobile ? constraints.maxWidth * 0.9 : 300,
                ),
                _buildRoleCard(
                  title: "Director of JUMVEA",
                  description:
                      "Contributing to the development and regulation of Japan's used vehicle export industry through the Japan Used Motor Vehicle Exporters Association.",
                  icon: Icons.directions_car,
                  width: isMobile ? constraints.maxWidth * 0.9 : 300,
                ),
                _buildRoleCard(
                  title: "Former President of SLAAJ",
                  description:
                      "Served as President of Sri Lanka Automobile Association in Japan (2012-2017), fostering automotive industry connections between the two nations.",
                  icon: Icons.group,
                  width: isMobile ? constraints.maxWidth * 0.9 : 300,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  /// Leadership Role Card with Hover Effect
  Widget _buildRoleCard({
    required String title,
    required String description,
    required IconData icon,
    required double width,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(icon, size: 32, color: Colors.red),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
