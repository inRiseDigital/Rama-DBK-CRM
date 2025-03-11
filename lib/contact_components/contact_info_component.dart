import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoComponent extends StatelessWidget {
  const ContactInfoComponent({super.key});

  Future<void> _launchMap() async {
    final Uri mapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=35.6812,139.7671',
    );
    if (await canLaunchUrl(mapsUrl)) {
      await launchUrl(mapsUrl);
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneUrl = Uri(
      scheme: 'tel',
      path: '+81123456789',
    );
    if (await canLaunchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailUrl = Uri(
      scheme: 'mailto',
      path: 'contact@rama-dbk.com',
    );
    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: _launchMap,
            child: _buildContactItem(
              Icons.location_on,
              'Address',
              '123 Business Street\nTokyo, Japan 123-4567',
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: _launchPhone,
            child: _buildContactItem(
              Icons.phone,
              'Phone',
              '+81 123-456-7890',
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: _launchEmail,
            child: _buildContactItem(
              Icons.email,
              'Email',
              'contact@rama-dbk.com',
            ),
          ),
          const SizedBox(height: 16),
          _buildContactItem(
            Icons.access_time,
            'Business Hours',
            'Monday - Friday: 9:00 AM - 6:00 PM\nSaturday: 10:00 AM - 4:00 PM\nSunday: Closed',
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFF2D3748),
          size: 24,
        ),
        const SizedBox(width: 16),
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
