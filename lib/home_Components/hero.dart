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
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOutCubic,
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
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 768;

    return SizedBox(
      height: size.height * 0.9,
      width: double.infinity,
      child: Stack(
        children: [
          // PageView with scaling and fading effect for a smooth, modern transition
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _backgroundImages.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  } else {
                    value = index == 0 ? 1.0 : 0.7;
                  }
                  return Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: Curves.easeOut.transform(value),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(_backgroundImages[index]),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // Fixed content overlay
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 30.0 : 80.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _fixedContent['title'],
                      style: TextStyle(
                        fontSize: isMobile ? 48 : 72,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                        height: 1.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isMobile ? 24 : 32),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? double.infinity : 700,
                      ),
                      child: Text(
                        _fixedContent['description'],
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: isMobile ? 40 : 56),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _fixedContent['buttons'].length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _buildActionButton(
                            _fixedContent['buttons'][index]['text'],
                            _fixedContent['buttons'][index]['color'],
                            _fixedContent['buttons'][index]['icon'],
                            isMobile,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Indicators
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
          // Down arrow icon
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

  Widget _buildActionButton(
    String text,
    Color color,
    IconData icon,
    bool isMobile,
  ) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform:
                isHovered
                    ? (Matrix4.identity()..scale(1.05))
                    : Matrix4.identity(),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((
                  states,
                ) {
                  if (states.contains(MaterialState.hovered))
                    return color.withOpacity(0.8);
                  return color;
                }),
                elevation: MaterialStateProperty.resolveWith<double>((states) {
                  if (states.contains(MaterialState.hovered)) return 6;
                  return 3;
                }),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 30,
                    vertical: isMobile ? 14 : 18,
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
                      fontSize: isMobile ? 14 : 16,
                      letterSpacing: 0.5,
                    ),
                    child: Text(text),
                  ),
                  const SizedBox(width: 10),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform:
                        isHovered
                            ? (Matrix4.identity()..translate(5.0, 0.0))
                            : Matrix4.identity(),
                    child: Icon(
                      icon,
                      size: isMobile ? 16 : 18,
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

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
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
