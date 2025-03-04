import 'package:flutter/material.dart';

/// Footer Component for RamaDBK Website
///
/// A responsive footer that adapts to different screen sizes.
/// Contains company information, navigation links, contact information,
/// newsletter subscription, and social media links.
///
/// Hover effects are added for desktop/web via `_HoverLink` and `_HoverIcon`.
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
      child:
          isMobile
              ? _buildMobileFooter()
              : isTablet
              ? _buildTabletFooter()
              : _buildDesktopFooter(),
    );
  }

  // -------------------------------------------------------
  //  Desktop Layout
  // -------------------------------------------------------
  Widget _buildDesktopFooter() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Information
            Expanded(flex: 3, child: _buildCompanyInfo()),

            // Quick Links
            Expanded(flex: 2, child: _buildQuickLinks()),

            // Services
            Expanded(flex: 2, child: _buildServices()),

            // Contact & Newsletter
            Expanded(flex: 3, child: _buildContactNewsletter()),
          ],
        ),
        const SizedBox(height: 40),
        _buildDivider(),
        const SizedBox(height: 20),
        _buildBottomSection(),
      ],
    );
  }

  // -------------------------------------------------------
  //  Tablet Layout
  // -------------------------------------------------------
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

  // -------------------------------------------------------
  //  Mobile Layout
  // -------------------------------------------------------
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

  // -------------------------------------------------------
  //  Company Info
  // -------------------------------------------------------
  Widget _buildCompanyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/Rama_logo.png',
          height: 50,
          // Fallback if image doesn't exist
          errorBuilder:
              (context, error, stackTrace) => Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Center(
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

        // "RamaDBK LTD\nJapanese Car Exporter"
        const Text(
          'RamaDBK LTD\nJapanese Car Exporter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 10),

        const Text(
          'Premium vehicle dealership offering a wide range of luxury '
          'and performance vehicles with exceptional customer service.',
          style: TextStyle(color: Colors.white70, height: 1.5),
        ),
        const SizedBox(height: 20),

        _buildSocialLinks(),
      ],
    );
  }

  // -------------------------------------------------------
  //  Quick Links (+ Other Info)
  // -------------------------------------------------------
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

        const SizedBox(height: 20),
        const Text(
          'Other Info',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _buildFooterLink('Shipping Info'),
        _buildFooterLink('Route to RamaDBK'),
        _buildFooterLink('OCD/Meter Check Service'),
        _buildFooterLink('Why Japanese Used Cars'),
        _buildFooterLink('Our Bank Details'),
        _buildFooterLink('Latest News'),
      ],
    );
  }

  // -------------------------------------------------------
  //  Our Services (+ Customer Services)
  // -------------------------------------------------------
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

        const SizedBox(height: 20),
        const Text(
          'Customer Services',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _buildFooterLink('Search for a car'),
        _buildFooterLink('After Sales Guarantee'),
        _buildFooterLink('Car Insurance'),
        _buildFooterLink('Payment Security'),
        _buildFooterLink('Sales Team'),
        _buildFooterLink('Import Regulations'),
        _buildFooterLink('Request Call Back'),
      ],
    );
  }

  // -------------------------------------------------------
  //  Contact & Newsletter
  // -------------------------------------------------------
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
        _buildContactItem(
          Icons.location_on,
          '201 Rama HQ Building, 2-1-17 Shinkoyasu,\n'
          'Kanagawa-ku, Yokohama, Japan\n'
          'Post Code 221-0013',
        ),
        _buildContactItem(Icons.phone, '+81-45-402-6117'),
        _buildContactItem(Icons.fax_outlined, '+81-45-402-0689'),
        _buildContactItem(Icons.email, 'sales@ramadbk.com'),
        _buildContactItem(Icons.web, 'www.RamaDBK.com'),
        _buildContactItem(Icons.phone_android, '+81-90-5580-6914'),

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

  // -------------------------------------------------------
  //  Footer Link (with hover)
  // -------------------------------------------------------
  Widget _buildFooterLink(String text) {
    // Instead of a simple InkWell, we use our new _HoverLink widget.
    return _HoverLink(
      text: text,
      icon: Icons.arrow_right, // same icon you used before
      onTap: () {
        // TODO: Implement navigation
      },
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.red, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
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
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Your Email',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement subscribe action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text('Subscribe'),
            ),
          ],
        ),
      ],
    );
  }

  // -------------------------------------------------------
  //  Social Links (with hover icons)
  // -------------------------------------------------------
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
        const SizedBox(width: 10),
        // e.g., DMCA protected
        _buildSocialIcon(Icons.security, tooltip: 'DMCA Protected'),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, {String? tooltip}) {
    return _HoverIcon(
      icon: icon,
      tooltip: tooltip,
      onPressed: () {
        // TODO: Implement social link action
      },
    );
  }

  // -------------------------------------------------------
  //  Divider
  // -------------------------------------------------------
  Widget _buildDivider() {
    return Container(height: 1, color: Colors.white12);
  }

  // -------------------------------------------------------
  //  Bottom Section (Optional hover on links)
  // -------------------------------------------------------
  Widget _buildBottomSection({bool isMobile = false}) {
    return isMobile
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '© 2025 RamaDBK. All Rights Reserved.',
              style: TextStyle(color: Colors.white54, fontSize: 14),
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
              style: TextStyle(color: Colors.white54, fontSize: 14),
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
    // Use the same hover link approach for these bottom links if you want.
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: _HoverLink(
        text: text,
        icon: null, // No arrow icon here
        hoverColor: Colors.white70,
        onTap: () {
          // TODO: Implement navigation
        },
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

// --------------------------------------------------
//  HOVER WIDGETS
// --------------------------------------------------

/// A link widget that detects mouse hover and changes style accordingly.
class _HoverLink extends StatefulWidget {
  final String text;
  final IconData? icon;
  final Color hoverColor;
  final VoidCallback? onTap;

  const _HoverLink({
    Key? key,
    required this.text,
    this.icon,
    this.hoverColor = Colors.white,
    this.onTap,
  }) : super(key: key);

  @override
  State<_HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<_HoverLink> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null)
                Icon(
                  widget.icon,
                  color: _isHovering ? widget.hoverColor : Colors.red,
                  size: 16,
                ),
              if (widget.icon != null) const SizedBox(width: 5),
              Text(
                widget.text,
                style: TextStyle(
                  color: _isHovering ? widget.hoverColor : Colors.white70,
                  fontSize: 14,
                  decoration:
                      _isHovering
                          ? TextDecoration.underline
                          : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A circular icon button that detects mouse hover and changes style accordingly.
class _HoverIcon extends StatefulWidget {
  final IconData icon;
  final String? tooltip;
  final VoidCallback onPressed;

  const _HoverIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
  }) : super(key: key);

  @override
  State<_HoverIcon> createState() => _HoverIconState();
}

class _HoverIconState extends State<_HoverIcon> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip ?? '',
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _isHovering ? Colors.white24 : Colors.white12,
            borderRadius: BorderRadius.circular(18),
          ),
          child: IconButton(
            icon: Icon(
              widget.icon,
              color: _isHovering ? Colors.red : Colors.white,
              size: 18,
            ),
            onPressed: widget.onPressed,
          ),
        ),
      ),
    );
  }
}
