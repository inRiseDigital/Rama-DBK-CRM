import 'package:flutter/material.dart';
import 'package:rama_dbk_crm/about_components/about_hero_component.dart';
import 'package:rama_dbk_crm/about_components/company_background_section.dart';
import 'package:rama_dbk_crm/about_components/fact_figures_component.dart';
import 'package:rama_dbk_crm/about_components/management_message.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                const AboutHeroComponent(),
                const SizedBox(height: 64),
                const Text(
                  'About Us',
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
                  'Learn about our journey, values, and commitment to providing quality vehicles and exceptional service to our customers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF718096),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                const CompanyBackgroundSection(),
                const SizedBox(height: 48),
                const FactFiguresComponent(),
                const SizedBox(height: 48),
                const ManagementMessage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
