import 'package:flutter/material.dart';

class ContactHeroComponent extends StatefulWidget {
  const ContactHeroComponent({super.key});

  @override
  State<ContactHeroComponent> createState() => _ContactHeroComponentState();
}

class _ContactHeroComponentState extends State<ContactHeroComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeInAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;

    return FadeTransition(
      opacity: _fadeInAnimation,
      child: Container(
        width: double.infinity,
        height: isMobile ? 300 : 400,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/car_yard.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color(0xFF1A365D),
              BlendMode.overlay,
            ),
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 64,
            vertical: isMobile ? 48 : 64,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Get in Touch',
                style: TextStyle(
                  fontSize: isMobile ? 36 : 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE53E3E),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'We\'re here to help with all your vehicle needs.\nReach out to us for any inquiries or support.',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
