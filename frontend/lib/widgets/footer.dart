import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

/// Footer Component for RamaDBK Website
///
/// A responsive footer that adapts to different screen sizes.
/// - Desktop/Tablet: Shows all columns (Company Info, Quick Links, Services, Contact, etc.)
/// - Mobile: Shows **only** the Contact & Newsletter section and bottom copyright.
/// Hover effects are added for desktop/web via `_HoverLink` and `_HoverIcon`.
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
      child: Column(
        children: [
          _buildFooterContent(context),
          const SizedBox(height: 30),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildFooterContent(BuildContext context) {
    return Wrap(
      spacing: 30,
      runSpacing: 30,
      children: [
        _buildAboutSection(context),
        _buildServicesSection(context),
        _buildContactSection(context),
        _buildNewsletterSection(),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/Rama_logo.png',
            height: 50,
            // Fallback if image doesn't exist
            errorBuilder: (context, error, stackTrace) => Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
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
            'Premium vehicle dealership offering a wide range of luxury and performance vehicles with exceptional customer service.',
            style: TextStyle(color: Colors.white70, height: 1.5),
          ),
          const SizedBox(height: 20),
          // Social icons (desktop/tablet only)
          _buildSocialLinks(),
        ],
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
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
          _buildFooterLink(context, 'New Vehicles'),
          _buildFooterLink(context, 'Pre-Owned Vehicles'),
          _buildFooterLink(context, 'Financing Options'),
          _buildFooterLink(context, 'Vehicle Maintenance'),
          _buildFooterLink(context, 'Parts & Accessories'),
          _buildFooterLink(context, 'Trade-In Appraisal'),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Info',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildFooterLink(context, 'Search for a car'),
          _buildFooterLink(context, 'After Sales Guarantee'),
          _buildFooterLink(context, 'Car Insurance'),
          _buildFooterLink(context, 'Payment Security'),
          _buildFooterLink(context, 'Sales Team'),
          _buildFooterLink(context, 'Import Regulations'),
          _buildFooterLink(context, 'Request Call Back'),
        ],
      ),
    );
  }

  Widget _buildNewsletterSection() {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Newsletter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Subscribe to receive updates on new arrivals and special offers',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 15),
          _NewsletterForm(),
        ],
      ),
    );
  }

  // -------------------------------------------------------
  //  Footer Link (with hover)
  // -------------------------------------------------------
  Widget _buildFooterLink(BuildContext context, String text) {
    String route = _getRouteFromText(text);
    return _HoverLink(
      text: text,
      icon: Icons.arrow_right,
      onTap: () {
        GoRouter.of(context).go(route);
      },
    );
  }

  String _getRouteFromText(String text) {
    switch (text.toLowerCase()) {
      case 'home':
        return '/';
      case 'about us':
        return '/about';
      case 'services':
        return '/services';
      case 'spare parts':
        return '/spare-parts';
      case 'contact us':
        return '/contact';
      default:
        return '/';
    }
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
  //  Social Links (Desktop/Tablet only)
  // -------------------------------------------------------
  Widget _buildSocialLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _HoverIcon(
          icon: Icons.facebook,
          tooltip: 'Follow us on Facebook',
          onPressed: () => _launchSocialMedia('https://facebook.com/ramadbk'),
        ),
        const SizedBox(width: 10),
        _HoverIcon(
          icon: Icons.telegram,
          tooltip: 'Join our Telegram Channel',
          onPressed: () => _launchSocialMedia('https://t.me/ramadbk'),
        ),
        const SizedBox(width: 10),
        _HoverIcon(
          icon: Icons.message,
          tooltip: 'Contact us on WhatsApp',
          onPressed: () => _launchSocialMedia('https://wa.me/+81904025117'),
        ),
        const SizedBox(width: 10),
        _HoverIcon(
          icon: Icons.video_library,
          tooltip: 'Subscribe to our YouTube Channel',
          onPressed: () => _launchSocialMedia('https://youtube.com/ramadbk'),
        ),
        const SizedBox(width: 10),
        _HoverIcon(
          icon: Icons.language,
          tooltip: 'Visit our Website',
          onPressed: () => _launchSocialMedia('https://ramadbk.com'),
        ),
      ],
    );
  }

  Future<void> _launchSocialMedia(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  // -------------------------------------------------------
  //  Bottom Section
  // -------------------------------------------------------
  Widget _buildBottomBar() {
    return Row(
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
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: _HoverLink(
        text: text,
        icon: null,
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
                  decoration: _isHovering
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

class _NewsletterForm extends StatefulWidget {
  @override
  _NewsletterFormState createState() => _NewsletterFormState();
}

class _NewsletterFormState extends State<_NewsletterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _subscribe() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // TODO: Replace with your actual API endpoint
      final response = await http.post(
        Uri.parse('YOUR_API_ENDPOINT/subscribe'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': _emailController.text}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully subscribed to newsletter!'),
            backgroundColor: Colors.green,
          ),
        );
        _emailController.clear();
      } else {
        throw Exception('Failed to subscribe');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error subscribing: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: _isLoading ? null : _subscribe,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Subscribe'),
          ),
        ],
      ),
    );
  }
}
