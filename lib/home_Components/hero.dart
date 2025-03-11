import 'package:flutter/material.dart';
import 'dart:async';

/// Hero Component for RamaDBK Homepage
///
/// A simplified hero section with a compelling headline and description
/// that remain fixed while only the background images slide with modern,
/// smooth animations featuring scaling and fading transitions.

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late Timer _timer;
  late PageController _pageController;

  final List<String> _backgroundImages = [
    'assets/images/car_yard.png',
    'assets/images/trucks.png',
    'assets/images/vehicle_group.png',
  ];

  final Map<String, dynamic> _fixedContent = {
    'title': 'Drive Your Dreams',
    'description':
        'Experience luxury and performance with our exclusive collection of vehicles. Find your perfect match today and enjoy our award-winning customer service.',
    'buttons': [
      {
        'text': 'Explore Vehicles',
        'icon': Icons.directions_car,
        'color': Colors.red,
      },
      {
        'text': 'Book Test Drive',
        'icon': Icons.calendar_today,
        'color': Colors.black,
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentIndex < _backgroundImages.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
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
    final size = MediaQuery.of(context).size;
    // "Mobile" breakpoint for tablets or smaller
    final bool isMobile = size.width < 768;
    // "Small phone" breakpoint for narrower devices than ~iPhone 8 (375px)
    final bool isSmallPhone = size.width < 375;

    return SizedBox(
      // Use up to 90% of the screen height
      height: size.height * 1.0,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Images with Slide Animation
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: _backgroundImages.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_backgroundImages[index]),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  ),
                ),
              );
            },
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.4),
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),

          // 2) Main hero content overlay
          Positioned.fill(
            child: Padding(
              // Extra-little horizontal padding on small phones
              padding: EdgeInsets.symmetric(
                horizontal: isSmallPhone ? 16.0 : (isMobile ? 30.0 : 80.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Headline
                    Text(
                      _fixedContent['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmallPhone ? 32 : (isMobile ? 48 : 72),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: isSmallPhone ? 16 : (isMobile ? 24 : 32)),

                    // Description
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? double.infinity : 700,
                      ),
                      child: Text(
                        _fixedContent['description'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isSmallPhone ? 14 : (isMobile ? 16 : 18),
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: isSmallPhone ? 24 : (isMobile ? 40 : 56)),

                    // 3) Buttons
                    if (isSmallPhone)
                      // If the screen is really narrow, stack the buttons vertically
                      Column(
                        children: [
                          _buildActionButton(
                            text: _fixedContent['buttons'][0]['text'],
                            color: _fixedContent['buttons'][0]['color'],
                            icon: _fixedContent['buttons'][0]['icon'],
                            isMobile: isMobile,
                            isSmallPhone: isSmallPhone,
                          ),
                          const SizedBox(height: 12),
                          _buildActionButton(
                            text: _fixedContent['buttons'][1]['text'],
                            color: _fixedContent['buttons'][1]['color'],
                            icon: _fixedContent['buttons'][1]['icon'],
                            isMobile: isMobile,
                            isSmallPhone: isSmallPhone,
                          ),
                        ],
                      )
                    else
                      // Normal horizontal layout on wider phones
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _fixedContent['buttons'].length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: _buildActionButton(
                              text: _fixedContent['buttons'][index]['text'],
                              color: _fixedContent['buttons'][index]['color'],
                              icon: _fixedContent['buttons'][index]['icon'],
                              isMobile: isMobile,
                              isSmallPhone: isSmallPhone,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // 4) Indicators (dots)
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _backgroundImages.length,
                (index) => _buildIndicator(index == _currentIndex),
              ),
            ),
          ),

          // 5) Down arrow icon
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

  /// Action Button
  Widget _buildActionButton({
    required String text,
    required Color color,
    required IconData icon,
    required bool isMobile,
    required bool isSmallPhone,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: isHovered
                ? (Matrix4.identity()..scale(1.05))
                : Matrix4.identity(),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) => states.contains(MaterialState.hovered)
                      ? color.withOpacity(0.8)
                      : color,
                ),
                elevation: MaterialStateProperty.resolveWith<double>(
                  (states) => states.contains(MaterialState.hovered) ? 6 : 3,
                ),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: isSmallPhone ? 16 : (isMobile ? 20 : 30),
                    vertical: isSmallPhone ? 10 : (isMobile ? 14 : 18),
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: isSmallPhone ? 12 : (isMobile ? 14 : 16),
                      letterSpacing: 0.5,
                    ),
                    child: Text(text),
                  ),
                  const SizedBox(width: 10),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: isHovered
                        ? (Matrix4.identity()..translate(5.0, 0.0))
                        : Matrix4.identity(),
                    child: Icon(
                      icon,
                      size: isSmallPhone ? 14 : (isMobile ? 16 : 18),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Page indicator widget
  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.red : const Color(0xFF8E8E8E).withOpacity(0.4),
        borderRadius: BorderRadius.circular(4),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
    );
  }
}
