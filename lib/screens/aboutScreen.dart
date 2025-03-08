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
        children: [
          AboutHeroComponent(),
          CompanyBackgroundSection(),
          FactFiguresComponent(),
          ManagementMessage(),
        ],
      ),
    );
  }
}
