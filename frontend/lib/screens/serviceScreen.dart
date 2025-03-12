import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../our_service_component/service_card.dart';
import '../our_service_component/contact_section.dart';
import '../our_service_component/hero_section.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  void _handleLearnMore(BuildContext context, String service) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(service),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _getServiceDetails(service),
                const SizedBox(height: 16),
                const Text(
                  'Would you like to schedule this service?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.push('/booking', extra: {'service': service});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D3748),
              ),
              child: const Text('Schedule Service'),
            ),
          ],
        );
      },
    );
  }

  Widget _getServiceDetails(String service) {
    switch (service) {
      case 'Vehicle Maintenance':
        return const Text(
          'Our comprehensive vehicle maintenance service includes:\n\n'
          '• Complete multi-point inspection\n'
          '• Oil and filter change\n'
          '• Brake system check\n'
          '• Tire rotation and balancing\n'
          '• Fluid level checks and top-ups\n'
          '• Battery health check\n'
          '• Air conditioning performance check\n'
          '• Suspension system inspection\n\n'
          'Regular maintenance helps prevent costly repairs and extends your vehicle\'s life.',
          style: TextStyle(height: 1.5),
        );
      case 'Diagnostics':
        return const Text(
          'Our advanced diagnostic services include:\n\n'
          '• State-of-the-art diagnostic equipment\n'
          '• Engine performance analysis\n'
          '• Electrical system testing\n'
          '• Emissions system diagnosis\n'
          '• Computer system scanning\n'
          '• Sensor functionality testing\n'
          '• Trouble code reading and analysis\n'
          '• Performance optimization recommendations\n\n'
          'We identify issues quickly and accurately to get your vehicle back on the road.',
          style: TextStyle(height: 1.5),
        );
      case 'Repairs':
        return const Text(
          'Our professional repair services cover:\n\n'
          '• Engine repairs and rebuilds\n'
          '• Transmission repairs\n'
          '• Brake system repairs\n'
          '• Suspension and steering fixes\n'
          '• Electrical system repairs\n'
          '• Cooling system repairs\n'
          '• Exhaust system repairs\n'
          '• Air conditioning repairs\n\n'
          'All repairs are performed by certified technicians using quality parts.',
          style: TextStyle(height: 1.5),
        );
      case 'Parts Replacement':
        return const Text(
          'Our parts replacement service features:\n\n'
          '• Genuine OEM parts\n'
          '• Quality aftermarket options\n'
          '• Comprehensive parts warranty\n'
          '• Expert installation\n'
          '• Competitive pricing\n'
          '• Parts availability check\n'
          '• Performance upgrades\n'
          '• Parts disposal service\n\n'
          'We ensure your vehicle gets the right parts, properly installed.',
          style: TextStyle(height: 1.5),
        );
      case 'Body Work':
        return const Text(
          'Our body work services include:\n\n'
          '• Collision repair\n'
          '• Paint matching and refinishing\n'
          '• Dent removal\n'
          '• Rust repair and prevention\n'
          '• Panel replacement\n'
          '• Frame straightening\n'
          '• Glass replacement\n'
          '• Paint protection\n\n'
          'We restore your vehicle to its original condition with attention to detail.',
          style: TextStyle(height: 1.5),
        );
      case 'Emergency Services':
        return const Text(
          'Our emergency services provide:\n\n'
          '• 24/7 emergency support\n'
          '• Roadside assistance\n'
          '• Emergency repairs\n'
          '• Towing service\n'
          '• Jump start service\n'
          '• Tire change service\n'
          '• Fuel delivery\n'
          '• Lock-out assistance\n\n'
          'We\'re here when you need us, any time, day or night.',
          style: TextStyle(height: 1.5),
        );
      default:
        return const Text('Service details not available.');
    }
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
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Our Services',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                          letterSpacing: -1,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'We provide comprehensive automotive services to keep your vehicle running at its best. Our experienced technicians use state-of-the-art equipment to deliver quality service.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF718096),
                          height: 1.5,
                        ),
                      ),
                    ],
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
                      features: const [
                        'Regular oil and filter changes',
                        'Brake system inspection and service',
                        'Tire rotation and balancing',
                        'Multi-point vehicle inspection',
                        'Fluid level checks and top-ups',
                      ],
                      onTap: () =>
                          _handleLearnMore(context, 'Vehicle Maintenance'),
                    ),
                    ServiceCard(
                      title: 'Diagnostics',
                      description:
                          'Advanced diagnostic services to identify and resolve vehicle issues.',
                      icon: Icons.search,
                      features: const [
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
                      features: const [
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
                      features: const [
                        'Genuine OEM parts',
                        'Quality aftermarket options',
                        'Parts warranty coverage',
                        'Expert installation',
                        'Competitive pricing',
                      ],
                      onTap: () =>
                          _handleLearnMore(context, 'Parts Replacement'),
                    ),
                    ServiceCard(
                      title: 'Body Work',
                      description:
                          'Complete body repair and painting services.',
                      icon: Icons.format_paint,
                      features: const [
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
                      features: const [
                        '24/7 emergency support',
                        'Roadside assistance',
                        'Emergency repairs',
                        'Towing service',
                        'Jump start service',
                      ],
                      onTap: () =>
                          _handleLearnMore(context, 'Emergency Services'),
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
