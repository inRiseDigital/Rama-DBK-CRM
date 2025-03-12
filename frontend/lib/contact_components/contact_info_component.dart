import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoComponent extends StatefulWidget {
  const ContactInfoComponent({super.key});

  @override
  State<ContactInfoComponent> createState() => _ContactInfoComponentState();
}

class _ContactInfoComponentState extends State<ContactInfoComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  final Map<String, bool> _isHovering = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeInAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchMap() async {
    final Uri mapsUrl = Uri.parse(
      'https://www.google.com/maps/place/RAMA+DBK/@-6.2115247,106.8341445,17z',
    );
    if (await canLaunchUrl(mapsUrl)) {
      await launchUrl(mapsUrl);
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneUrl = Uri(
      scheme: 'tel',
      path: '+622183708889',
    );
    if (await canLaunchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailUrl = Uri(
      scheme: 'mailto',
      path: 'info@ramadbk.com',
    );
    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return FadeTransition(
      opacity: _fadeInAnimation,
      child: Container(
        padding: EdgeInsets.all(isMobile ? 24 : 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: TextStyle(
                fontSize: isMobile ? 24 : 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Get in touch with us through any of the following channels',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                color: const Color(0xFF718096),
              ),
            ),
            const SizedBox(height: 32),
            _buildContactCard(
              title: 'Visit Our Office',
              icon: Icons.location_on,
              content:
                  'Jl. Raya Kalimalang No.3A\nPondok Kelapa, Duren Sawit\nJakarta Timur 13450\nIndonesia',
              onTap: _launchMap,
              color: const Color(0xFFE53E3E),
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              title: 'Call Us',
              icon: Icons.phone,
              content: '+62 21 8370 8889',
              onTap: _launchPhone,
              color: const Color(0xFF48BB78),
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              title: 'Email Us',
              icon: Icons.email,
              content: 'info@ramadbk.com',
              onTap: _launchEmail,
              color: const Color(0xFF4299E1),
            ),
            const SizedBox(height: 16),
            _buildContactCard(
              title: 'Business Hours',
              icon: Icons.access_time,
              content:
                  'Monday - Friday: 8:00 AM - 5:00 PM\nSaturday: 8:00 AM - 2:00 PM\nSunday: Closed',
              color: const Color(0xFFF6AD55),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required String title,
    required IconData icon,
    required String content,
    required Color color,
    VoidCallback? onTap,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering[title] = true),
      onExit: (_) => setState(() => _isHovering[title] = false),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _isHovering[title] == true
                ? color.withOpacity(0.1)
                : Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovering[title] == true ? color : Colors.grey[200]!,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      content,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF718096),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null) ...[
                const SizedBox(width: 16),
                Icon(
                  Icons.arrow_forward_ios,
                  color: color,
                  size: 16,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
