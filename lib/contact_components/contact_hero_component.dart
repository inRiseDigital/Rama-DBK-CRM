import 'package:flutter/material.dart';

class ContactHeroComponent extends StatelessWidget {
  const ContactHeroComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        image: DecorationImage(
          image: const AssetImage('assets/images/contact_hero.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Get In Touch',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'We\'re here to help and answer any questions you might have',
              style: TextStyle(fontSize: 20, color: Colors.white, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
