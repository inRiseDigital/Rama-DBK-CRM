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
                const SizedBox(height: 10.0),
                Text(
                  'What Our Customers Say',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 24.0 : 36.0,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(width: 50.0, height: 3.0, color: Colors.red),
                const SizedBox(height: 40.0),
              ],
            ),
          ),

          // Testimonials
          isMobile
              ? Column(
                children: [
                  HoverTestimonialCard(
                    name: 'John Davis',
                    title: 'Business Executive',
                    testimonial:
                        'Exceptional service from start to finish. RamaDBK made my car buying experience smooth and enjoyable. I couldn\'t be happier with my new luxury sedan.',
                  ),
                  const SizedBox(height: 20.0),
                  HoverTestimonialCard(
                    name: 'Emily Johnson',
                    title: 'Marketing Director',
                    testimonial:
                        'The team at RamaDBK went above and beyond to help me find the perfect vehicle. Their knowledge and professionalism are unmatched in the industry.',
                  ),
                  const SizedBox(height: 20.0),
                  HoverTestimonialCard(
                    name: 'Robert Chen',
                    title: 'Tech Entrepreneur',
                    testimonial:
                        'As a repeat customer, I can confidently say that RamaDBK provides the best vehicle purchasing experience. Their selection of premium cars is impressive.',
                  ),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: HoverTestimonialCard(
                      name: 'John Davis',
                      title: 'Business Executive',
                      testimonial:
                          'Exceptional service from start to finish. RamaDBK made my car buying experience smooth and enjoyable. I couldn\'t be happier with my new luxury sedan.',
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: HoverTestimonialCard(
                      name: 'Emily Johnson',
                      title: 'Marketing Director',
                      testimonial:
                          'The team at RamaDBK went above and beyond to help me find the perfect vehicle. Their knowledge and professionalism are unmatched in the industry.',
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: HoverTestimonialCard(
                      name: 'Robert Chen',
                      title: 'Tech Entrepreneur',
                      testimonial:
                          'As a repeat customer, I can confidently say that RamaDBK provides the best vehicle purchasing experience. Their selection of premium cars is impressive.',
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}

/// A testimonial card widget that shows a hover effect on web/desktop.
class HoverTestimonialCard extends StatefulWidget {
  final String name;
  final String title;
  final String testimonial;

  const HoverTestimonialCard({
    super.key,
    required this.name,
    required this.title,
    required this.testimonial,
  });

  @override
  _HoverTestimonialCardState createState() => _HoverTestimonialCardState();
}

class _HoverTestimonialCardState extends State<HoverTestimonialCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter:
          (_) => setState(() {
            _isHovered = true;
          }),
      onExit:
          (_) => setState(() {
            _isHovered = false;
          }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform:
            _isHovered ? (Matrix4.identity()..scale(1.03)) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.2 : 0.1),
              blurRadius: _isHovered ? 25.0 : 20.0,
              offset: Offset(0, _isHovered ? 8 : 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.format_quote, color: Colors.red, size: 40.0),
            const SizedBox(height: 20.0),
            Text(
              widget.testimonial,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                height: 1.6,
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(width: 50.0, height: 1.0, color: Colors.red[300]),
            const SizedBox(height: 20.0),
            Text(
              widget.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.red, // Updated: Name text now in red.
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              widget.title,
              style: TextStyle(color: Colors.red[600], fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
