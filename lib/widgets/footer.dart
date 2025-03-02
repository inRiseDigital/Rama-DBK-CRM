import 'package:flutter/material.dart';

/// Footer Component for RamaDBK Website
///
/// A responsive footer that adapts to different screen sizes.
/// Contains company information, navigation links, contact information,
/// newsletter subscription, and social media links.

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    final bool isTablet = screenSize.width >= 768 && screenSize.width < 1200;

    return Container(
      color: const Color(0xFF1D1D1D),
      padding: EdgeInsets.symmetric(
        vertical: 50.0,
        horizontal: isMobile ? 20.0 : 50.0,
      ),
      child: isMobile
          ? _buildMobileFooter()
          : isTablet
              ? _buildTabletFooter()
              : _buildDesktopFooter(),
    );
  }

  Widget _buildDesktopFooter() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Information
            Expanded(
              flex: 3,
              child: _buildCompanyInfo(),
            ),
            
            // Quick Links
            Expanded(
              flex: 2,
              child: _buildQuickLinks(),
            ),
            
            // Services
            Expanded(
              flex: 2,
              child: _buildServices(),
            ),
            
            // Contact & Newsletter
            Expanded(
              flex: 3,
              child: _buildContactNewsletter(),
            ),
          ],
        ),
        const SizedBox(height: 40),
        _buildDivider(),
        const SizedBox(height: 20),
        _buildBottomSection(),
      ],
    );
  }

  Widget _buildTabletFooter() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Info and Quick Links
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCompanyInfo(),
                  const SizedBox(height: 30),
                  _buildQuickLinks(),
                ],
              ),
            ),
            
            // Services and Contact
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildServices(),
                  const SizedBox(height: 30),
                  _buildContactNewsletter(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        _buildDivider(),
        const SizedBox(height: 20),
        _buildBottomSection(),
      ],
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCompanyInfo(),
        const SizedBox(height: 30),
        _buildQuickLinks(),
        const SizedBox(height: 30),
        _buildServices(),
        const SizedBox(height: 30),
        _buildContactNewsletter(),
        const SizedBox(height: 40),
        _buildDivider(),
        const SizedBox(height: 20),
        _buildBottomSection(isMobile: true),
      ],
    );
  }

  Widget _buildCompanyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/Rama_logo.png',
          height: 50,
          // Fallback if image doesn't exist
          errorBuilder: (context, error, stackTrace) => Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'R',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'RamaDBK',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Premium vehicle dealership offering a wide range of luxury and performance vehicles with exceptional customer service.',
          style: TextStyle(
            color: Colors.white70,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        _buildSocialLinks(),
      ],
    );
  }

  Widget _buildQuickLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Links',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        _buildFooterLink('Home'),
        _buildFooterLink('About Us'),
        _buildFooterLink('Our Fleet'),
        _buildFooterLink('Testimonials'),
        _buildFooterLink('Blog'),
        _buildFooterLink('Contact Us'),
      ],
    );
  }

  Widget _buildServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our Services',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        _buildFooterLink('New Vehicles'),
        _buildFooterLink('Pre-Owned Vehicles'),
        _buildFooterLink('Financing Options'),
        _buildFooterLink('Vehicle Maintenance'),
        _buildFooterLink('Parts & Accessories'),
        _buildFooterLink('Trade-In Appraisal'),
      ],
    );
  }

  Widget _buildContactNewsletter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        _buildContactItem(Icons.location_on, '123 Automotive Avenue, Car City'),
        _buildContactItem(Icons.phone, '+1 (555) 123-4567'),
        _buildContactItem(Icons.email, 'info@ramadbk.com'),
        _buildContactItem(Icons.access_time, 'Mon-Sat: 9:00 AM - 6:00 PM'),
        const SizedBox(height: 25),
        const Text(
          'Newsletter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        _buildNewsletterSignup(),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.arrow_right,
              color: Colors.red,
              size: 16,
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.red,
            size: 16,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsletterSignup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Subscribe to receive updates on new arrivals and special offers',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Your Email',
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
              child: const Text('Subscribe'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      children: [
        _buildSocialIcon(Icons.facebook),
        const SizedBox(width: 10),
        _buildSocialIcon(Icons.phone_android),
        const SizedBox(width: 10),
        _buildSocialIcon(Icons.camera_alt),
        const SizedBox(width: 10),
        _buildSocialIcon(Icons.youtube_searched_for),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(18),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Colors.white12,
    );
  }

  Widget _buildBottomSection({bool isMobile = false}) {
    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '© 2025 RamaDBK. All Rights Reserved.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBottomLink('Privacy Policy'),
                  _buildBottomDot(),
                  _buildBottomLink('Terms of Service'),
                  _buildBottomDot(),
                  _buildBottomLink('Sitemap'),
                ],
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '© 2025 RamaDBK. All Rights Reserved.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  _buildBottomLink('Privacy Policy'),
                  _buildBottomDot(),
                  _buildBottomLink('Terms of Service'),
                  _buildBottomDot(),
                  _buildBottomLink('Sitemap'),
                ],
              ),
            ],
          );
  }

  Widget _buildBottomLink(String text) {
    return InkWell(
      onTap: () {},
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildBottomDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 3,
        height: 3,
        decoration: const BoxDecoration(
          color: Colors.white54,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}