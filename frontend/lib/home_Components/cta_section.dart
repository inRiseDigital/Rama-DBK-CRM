import 'package:flutter/material.dart';

/// CTA Section Component
///
/// A call-to-action section with a contact form and promotional content.
/// Features a responsive layout that adapts to different screen sizes.

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60.0,
        horizontal: isMobile ? 20.0 : 60.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red,
            Colors.red.shade800,
          ],
        ),
      ),
      child: isMobile
          ? Column(
              children: [
                _buildCtaContent(),
                const SizedBox(height: 30.0),
                _buildCtaForm(),
              ],
            )
          : Row(
              children: [
                Expanded(
                  flex: 5,
                  child: _buildCtaContent(),
                ),
                const SizedBox(width: 40.0),
                Expanded(
                  flex: 7,
                  child: _buildCtaForm(),
                ),
              ],
            ),
    );
  }

  Widget _buildCtaContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GET IN TOUCH',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Schedule a Test Drive Today',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          'Experience the thrill of driving a premium vehicle. Our team is ready to assist you in finding the perfect match for your lifestyle and preferences.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            height: 1.6,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 20.0),
        const Row(
          children: [
            Icon(
              Icons.phone,
              color: Colors.white,
              size: 20.0,
            ),
            SizedBox(width: 10.0),
            Text(
              '+1 (555) 123-4567',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Row(
          children: [
            Icon(
              Icons.email,
              color: Colors.white,
              size: 20.0,
            ),
            SizedBox(width: 10.0),
            Text(
              'info@ramadbk.com',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCtaForm() {
    return Container(
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20.0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Request Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: _buildFormField('First Name'),
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: _buildFormField('Last Name'),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          _buildFormField('Email Address'),
          const SizedBox(height: 15.0),
          _buildFormField('Phone Number'),
          const SizedBox(height: 15.0),
          _buildFormField('Preferred Vehicle'),
          const SizedBox(height: 15.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Message',
                contentPadding: EdgeInsets.all(15.0),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: const Text(
                'Submit Request',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String placeholder) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: placeholder,
          contentPadding: const EdgeInsets.all(15.0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}