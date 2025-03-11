import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchMaps() async {
    // Coordinates for Rama DBK
    const lat = -6.2088;
    const lng = 106.9001;
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch maps';
      }
    } catch (e) {
      debugPrint('Error launching maps: $e');
    }
  }

  Future<void> _launchPhone() async {
    final uri = Uri.parse('tel:0214890208');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch phone';
      }
    } catch (e) {
      debugPrint('Error launching phone: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Need Help?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Contact our service department for immediate assistance. Our expert team is ready to help you with any automotive needs.',
            style: TextStyle(fontSize: 16, color: Color(0xFF718096)),
          ),
          const SizedBox(height: 24),
          _buildContactInfo(
            Icons.location_on,
            'Location',
            'Jl. Raya Bekasi KM.17, No.9, RT.7/RW.3, Jatinegara Kaum, Kec. Pulo Gadung, Jakarta Timur, DKI Jakarta 13250',
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: _launchPhone,
            child: _buildContactInfo(Icons.phone, 'Phone', '(021) 4890208'),
          ),
          const SizedBox(height: 16),
          _buildContactInfo(
            Icons.access_time,
            'Business Hours',
            'Monday - Saturday: 08:00 - 17:00\nSunday: Closed',
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.push('/contact'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF2D55),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Contact Us'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: _launchMaps,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFFF2D55),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Color(0xFFFF2D55)),
                  ),
                  child: const Text('Get Directions'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: const Color(0xFFFF2D55)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 4),
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
      ],
    );
  }
}
