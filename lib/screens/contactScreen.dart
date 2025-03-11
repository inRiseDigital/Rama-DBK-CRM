import 'package:flutter/material.dart';
import 'package:rama_dbk_crm/contact_components/contact_hero_component.dart';
import 'package:rama_dbk_crm/contact_components/contact_form_component.dart';
import 'package:rama_dbk_crm/contact_components/contact_info_component.dart';
import 'package:rama_dbk_crm/contact_components/contact_map_component.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ContactHeroComponent(),
                const SizedBox(height: 64),
                const Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Get in touch with us for any inquiries about our vehicles, services, or spare parts. Our team is ready to assist you.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF718096),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                const ContactFormComponent(),
                const SizedBox(height: 48),
                const ContactInfoComponent(),
                const SizedBox(height: 48),
                const ContactMapComponent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
