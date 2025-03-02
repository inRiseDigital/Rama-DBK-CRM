import 'package:flutter/material.dart';

/// Testimonials Section Component
///
/// Displays customer testimonials in a responsive card layout.
/// Each testimonial includes a quote, customer name, and their title.

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60.0,
        horizontal: isMobile ? 20.0 : 60.0,
      ),
      color: Colors.grey[100],
      child: Column(
        children: [
          // Section Title
          Center(
            child: Column(
              children: [
                Text(
                  'TESTIMONIALS',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'What Our Customers Say',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 24.0 : 32.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: 50.0,
                  height: 3.0,
                  color: Colors.red,
                ),
                SizedBox(height: 40.0),
              ],
            ),
          ),
          
          // Testimonials
          isMobile
              ? Column(
                  children: [
                    _buildTestimonialCard(
                      'John Davis',
                      'Business Executive',
                      'Exceptional service from start to finish. RamaDBK made my car buying experience smooth and enjoyable. I couldn\'t be happier with my new luxury sedan.',
                    ),
                    SizedBox(height: 20.0),
                    _buildTestimonialCard(
                      'Emily Johnson',
                      'Marketing Director',
                      'The team at RamaDBK went above and beyond to help me find the perfect vehicle. Their knowledge and professionalism are unmatched in the industry.',
                    ),
                    SizedBox(height: 20.0),
                    _buildTestimonialCard(
                      'Robert Chen',
                      'Tech Entrepreneur',
                      'As a repeat customer, I can confidently say that RamaDBK provides the best vehicle purchasing experience. Their selection of premium cars is impressive.',
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildTestimonialCard(
                        'John Davis',
                        'Business Executive',
                        'Exceptional service from start to finish. RamaDBK made my car buying experience smooth and enjoyable. I couldn\'t be happier with my new luxury sedan.',
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: _buildTestimonialCard(
                        'Emily Johnson',
                        'Marketing Director',
                        'The team at RamaDBK went above and beyond to help me find the perfect vehicle. Their knowledge and professionalism are unmatched in the industry.',
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: _buildTestimonialCard(
                        'Robert Chen',
                        'Tech Entrepreneur',
                        'As a repeat customer, I can confidently say that RamaDBK provides the best vehicle purchasing experience. Their selection of premium cars is impressive.',
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(String name, String title, String testimonial) {
    return Container(
      padding: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.format_quote,
            color: Colors.red,
            size: 40.0,
          ),
          SizedBox(height: 20.0),
          Text(
            testimonial,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[700],
              height: 1.6,
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            width: 50.0,
            height: 1.0,
            color: Colors.grey[300],
          ),
          SizedBox(height: 20.0),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}