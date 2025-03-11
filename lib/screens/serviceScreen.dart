import 'package:flutter/material.dart';
import '../our_service_component/service_card.dart';
import '../our_service_component/contact_section.dart';
import '../our_service_component/hero_section.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  void _handleLearnMore(BuildContext context, String service) {
    // TODO: Implement learn more action
    print('Learn more about $service');
  }

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
                const ServiceHeroSection(),
                const SizedBox(height: 64),
                const Text(
                  'Our Services',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'We provide comprehensive automotive services to keep your vehicle running at its best. Our experienced technicians use state-of-the-art equipment to deliver quality service.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF718096),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    ServiceCard(
                      title: 'Vehicle Maintenance',
                      description:
                          'Regular maintenance and servicing to keep your vehicle in top condition.',
                      icon: Icons.build,
                      features: [
                        'Regular oil and filter changes',
                        'Brake system inspection and service',
                        'Tire rotation and balancing',
                        'Multi-point vehicle inspection',
                        'Fluid level checks and top-ups',
                      ],
                      onTap:
                          () =>
                              _handleLearnMore(context, 'Vehicle Maintenance'),
                    ),
                    ServiceCard(
                      title: 'Diagnostics',
                      description:
                          'Advanced diagnostic services to identify and resolve vehicle issues.',
                      icon: Icons.search,
                      features: [
                        'Computer diagnostic scanning',
                        'Engine performance testing',
                        'Electrical system diagnosis',
                        'Emission system testing',
                        'Comprehensive vehicle analysis',
                      ],
                      onTap: () => _handleLearnMore(context, 'Diagnostics'),
                    ),
                    ServiceCard(
                      title: 'Repairs',
                      description:
                          'Professional repair services for all types of vehicles.',
                      icon: Icons.car_repair,
                      features: [
                        'Engine repairs and rebuilds',
                        'Transmission service and repair',
                        'Suspension and steering repairs',
                        'Brake system repairs',
                        'Electrical system repairs',
                      ],
                      onTap: () => _handleLearnMore(context, 'Repairs'),
                    ),
                    ServiceCard(
                      title: 'Parts Replacement',
                      description:
                          'Genuine parts replacement and installation services.',
                      icon: Icons.settings,
                      features: [
                        'Genuine OEM parts',
                        'Quality aftermarket options',
                        'Parts warranty coverage',
                        'Expert installation',
                        'Competitive pricing',
                      ],
                      onTap:
                          () => _handleLearnMore(context, 'Parts Replacement'),
                    ),
                    ServiceCard(
                      title: 'Body Work',
                      description:
                          'Complete body repair and painting services.',
                      icon: Icons.format_paint,
                      features: [
                        'Collision repair',
                        'Paint matching and refinishing',
                        'Dent removal',
                        'Rust repair and prevention',
                        'Panel replacement',
                      ],
                      onTap: () => _handleLearnMore(context, 'Body Work'),
                    ),
                    ServiceCard(
                      title: 'Emergency Services',
                      description:
                          'Quick response emergency automotive assistance.',
                      icon: Icons.emergency,
                      features: [
                        '24/7 emergency support',
                        'Roadside assistance',
                        'Emergency repairs',
                        'Towing service',
                        'Jump start service',
                      ],
                      onTap:
                          () => _handleLearnMore(context, 'Emergency Services'),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                const ContactSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
