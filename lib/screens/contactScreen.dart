import 'package:flutter/material.dart';
import '../contact_components/contact_hero_component.dart';
import '../contact_components/contact_info_component.dart';
import '../contact_components/contact_form_component.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ContactHeroComponent(),
                const SizedBox(height: 64),
                const Text(
                  'Contact Us',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Get in touch with us for inquiries about our vehicles, services, or any other questions you may have.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF718096),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 1200) {
                      // Desktop layout
                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Expanded(
                              flex: 5,
                              child: ContactFormComponent(),
                            ),
                            SizedBox(width: 24),
                            Expanded(
                              flex: 4,
                              child: ContactInfoComponent(),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Mobile layout
                      return const Column(
                        children: [
                          ContactInfoComponent(),
                          SizedBox(height: 48),
                          ContactFormComponent(),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
