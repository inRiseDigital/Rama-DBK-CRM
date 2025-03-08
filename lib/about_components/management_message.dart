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
        Text(
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
        Text(
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
            Text(
              "Company Vision and Mission",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              "The history of RamaDBK runs as far back as 1988. Starting as a young entrepreneur, I established a company that has "
              "now become a leading exporter of Japanese vehicles worldwide. Despite initial challenges, we successfully introduced "
              "a shift in mindset, encouraging buyers to purchase from international dealers. Today, our digital platform makes vehicle "
              "export easier and more efficient, helping customers access quality automobiles globally.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "Our goal is to provide affordable, high-quality vehicles while ensuring customer satisfaction. We believe that a "
              "happy customer generates a positive chain reaction in the industry, contributing to our success worldwide. "
              "With a dedicated and professional team, we continue to expand our global reach while upholding transparency and trust.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
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
        Text(
          "Leadership & Industry Involvement",
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
            _buildRoleCard(
              title: "President of SLBCJ",
              description:
                  "Recognized by the Sri Lankan Embassy in Japan as an institution promoting business between Japan and Sri Lanka.",
              icon: Icons.business_center,
            ),
            _buildRoleCard(
              title: "President of SLAAJ (2012-2017)",
              description:
                  "Served as the President of Sri Lanka Automobile Association in Japan, a non-profit organization supporting the automotive industry.",
              icon: Icons.directions_car,
            ),
            _buildRoleCard(
              title: "Advisory Board Member of SLAAJ",
              description:
                  "Since 2017, I have continued serving on the board, strengthening connections between Sri Lanka and Japan in the automotive sector.",
              icon: Icons.group,
            ),
            _buildRoleCard(
              title: "Director of JUMVEA",
              description:
                  "Japan Used Motor Vehicle Exporters Association (JUMVEA) - Established under the Ministry of Economy, Trade, and Industry.",
              icon: Icons.public,
            ),
          ],
        ),
      ],
    );
  }

  /// Leadership Role Card with Hover Effect
  Widget _buildRoleCard({
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
}
