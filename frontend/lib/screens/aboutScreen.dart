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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AboutHeroComponent(),
                SizedBox(height: 64),
                Text(
                  'About Us',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                    letterSpacing: -1,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Learn about our journey, values, and commitment to providing quality vehicles and exceptional service to our customers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF718096),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 48),
                CompanyBackgroundSection(),
                SizedBox(height: 48),
                FactFiguresComponent(),
                SizedBox(height: 48),
                ManagementMessage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
