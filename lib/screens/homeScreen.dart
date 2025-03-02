import 'package:flutter/material.dart';
import 'package:rama_dbk_crm/home_Components/service_section.dart';
import '../home_Components/hero.dart';
import '../widgets/footer.dart';
import '../home_Components/featured_vehicles.dart';
import '../home_Components/about_section.dart';
import '../home_Components/statistics_section.dart';
import '../home_Components/testimonials_section.dart';
import '../home_Components/cta_section.dart';

/// HomeScreen for RamaDBK
///
/// The main landing page for the RamaDBK vehicle selling company.
/// Assembles all the individual components into a cohesive page.

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          // Animated Hero Section
          HeroSection(),
          
          // Featured Vehicles Section
          FeaturedVehicles(),
          
          // About Us Section
          AboutSection(),
          
          // Services Section
          ServicesSection(),
          
          // Statistics Section
          StatisticsSection(),
          
          // Testimonials Section
          TestimonialsSection(),
          
          // Call To Action Section
          CtaSection(),
          
          // Footer
          Footer(),
        ],
      ),
    );
  }
}