import 'package:flutter/material.dart';
import 'package:rama_dbk_crm/home_components/service_section.dart';
import '../home_components/hero.dart';
import '../home_components/about_section.dart';
import '../home_components/statistics_section.dart';
import '../home_components/testimonials_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          // Animated Hero Section
          HeroSection(),

          // Services Section
          ServicesSection(),

          // Statistics Section
          StatisticsSection(),

          // Testimonials Section
          TestimonialsSection(),

          // About Us Section
          AboutSection(),
        ],
      ),
    );
  }
}
