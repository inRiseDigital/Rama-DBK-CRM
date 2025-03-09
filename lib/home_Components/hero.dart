import 'package:flutter/material.dart';
import 'dart:async';

/// Hero Component for RamaDBK Homepage
///
/// An animated hero section that showcases vehicles with sliding animations,
/// dynamic text reveal effects, and responsive design for all screen sizes.
/// Features automatic image carousel and parallax scrolling effects.

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late Timer _timer;
  late PageController _pageController;

  final List<Map<String, dynamic>> _heroContent = [
    {
      'tag': 'SPECIAL OFFERS',
      'title': 'Exclusive Deals',
      'description':
          'Limited time offers on select models. Schedule a test drive today.',
      'image': 'assets/images/car_yard.png',
      'buttons': [
        {
          'text': 'Explore Vehicles',
          'icon': Icons.arrow_forward,
          'color': Colors.red,
        },
        {
          'text': 'Book Test Drive',
          'icon': Icons.directions_car,
          'color': Colors.white,
        },
      ],
    },
    {
      'tag': 'NEW ARRIVALS',
      'title': 'Premium Selection',
      'description':
          'Discover our latest collection of luxury vehicles. Unmatched quality and performance.',
      'image': 'assets/images/trucks.png',
      'buttons': [
        {
          'text': 'View Collection',
          'icon': Icons.arrow_forward,
          'color': Colors.red,
        },
        {
          'text': 'Book Test Drive',
          'icon': Icons.directions_car,
          'color': Colors.white,
        },
      ],
    },
    {
      'tag': 'PREMIUM SERVICE',
      'title': 'Excellence Guaranteed',
      'description':
          'Experience our award-winning customer service and after-sales support.',
      'image': 'assets/images/vehicle_group.png',
      'buttons': [
        {
          'text': 'Our Services',
          'icon': Icons.arrow_forward,
          'color': Colors.red,
        },
        {'text': 'Contact Us', 'icon': Icons.phone, 'color': Colors.white},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    // Set up timer for auto-sliding
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (_currentIndex < _heroContent.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;

    return SizedBox(
      height: isMobile ? screenSize.height * 1 : screenSize.height * 1,
      width: double.infinity,
      child: Stack(
        children: [
          // PageView for sliding content
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _heroContent.length,
            itemBuilder: (context, index) {
              return _buildHeroSlide(context, _heroContent[index], isMobile);
            },
          ),

          // Carousel indicator dots
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _heroContent.length,
                (index) => _buildIndicator(index == _currentIndex),
              ),
            ),
          ),

          // Down arrow indicator
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white.withOpacity(0.6),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSlide(
    BuildContext context,
    Map<String, dynamic> content,
    bool isMobile,
  ) {
    return Stack(
      children: [
        // Background image with semi-transparent overlay
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage(content['image']),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
            ),
          ),
        ),

        // Content overlay
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 30.0 : 80.0,
            vertical: isMobile ? 60.0 : 100.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content['tag'],
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 16.0 : 18.0,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: isMobile ? 12.0 : 20.0),
              Text(
                content['title'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 38.0 : 54.0,
                  letterSpacing: 0.5,
                  height: 1.1,
                ),
              ),
              SizedBox(height: isMobile ? 16.0 : 24.0),
              Text(
                content['description'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: isMobile ? 16.0 : 18.0,
                  height: 1.4,
                ),
              ),
              SizedBox(height: isMobile ? 30.0 : 40.0),
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: [
                  for (final button in content['buttons'])
                    _buildActionButton(
                      button['text'],
                      button['color'],
                      button['icon'],
                      () {},
                      isMobile,
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String text,
    Color color,
    IconData icon,
    VoidCallback onPressed,
    bool isMobile,
  ) {
    final bool isRedButton = color == Colors.red;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: isRedButton ? Colors.white : Colors.black87,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side:
              isRedButton
                  ? BorderSide.none
                  : BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20.0 : 28.0,
          vertical: isMobile ? 12.0 : 16.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: isMobile ? 14.0 : 16.0,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: isMobile ? 16.0 : 18.0),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 22 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.red : Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
