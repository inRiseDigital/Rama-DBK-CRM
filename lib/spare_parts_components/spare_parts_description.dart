import 'package:flutter/material.dart';

class SparePartsDescription extends StatefulWidget {
  const SparePartsDescription({Key? key}) : super(key: key);

  @override
  _SparePartsDescriptionState createState() => _SparePartsDescriptionState();
}

class _SparePartsDescriptionState extends State<SparePartsDescription> {
  // Scroll controller to track scrolling position
  late ScrollController _scrollController;
  // Map to track if sections have been animated
  Map<String, bool> _animatedSections = {
    'title': false,
    'intro': false,
    'usedParts': false,
    'bullet1': false,
    'bullet2': false,
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Add listener to controller to check scroll position
    _scrollController.addListener(_checkScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_checkScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Check scroll position to trigger animations
  void _checkScroll() {
    final double offset = _scrollController.offset;
    final double maxScrollExtent = _scrollController.position.maxScrollExtent;

    // Animate sections based on scroll position
    setState(() {
      if (offset > 0) {
        _animatedSections['title'] = true;
      }
      if (offset > maxScrollExtent * 0.1) {
        _animatedSections['intro'] = true;
      }
      if (offset > maxScrollExtent * 0.3) {
        _animatedSections['usedParts'] = true;
      }
      if (offset > maxScrollExtent * 0.5) {
        _animatedSections['bullet1'] = true;
      }
      if (offset > maxScrollExtent * 0.7) {
        _animatedSections['bullet2'] = true;
      }
    });
  }

  /// Main Build
  @override
  Widget build(BuildContext context) {
    // Set all animations to true on first build for preview purposes
    // In production, you'd rely solely on scroll position
    Future.delayed(Duration.zero, () {
      if (mounted) {
        setState(() {
          _animatedSections = Map.fromEntries(
            _animatedSections.entries.map((e) => MapEntry(e.key, true)),
          );
        });
      }
    });

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitle(),
                const SizedBox(height: 30),
                _buildIntroParagraph(),
                const SizedBox(height: 40),
                _buildUsedPartsSection(),
                const SizedBox(height: 40),
                _buildBulletPoints(),
                // Add extra space at the bottom to allow scrolling
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Title: "Are You Looking for Auto Parts from Japan?"
  Widget _buildTitle() {
    return AnimatedOpacity(
      opacity: _animatedSections['title']! ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset:
            _animatedSections['title']! ? Offset.zero : const Offset(0, -0.2),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutQuart,
        child: Column(
          children: [
            // Using RichText to style part of the sentence in red
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Are You Looking for ',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
                children: [
                  TextSpan(
                    text: 'Auto Parts',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      letterSpacing: 0.5,
                    ),
                  ),
                  TextSpan(
                    text: ' from Japan?',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Animated underline that grows
            AnimatedContainer(
              duration: const Duration(milliseconds: 1200),
              width: _animatedSections['title']! ? 120 : 0,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Intro Paragraph with improved styling
  Widget _buildIntroParagraph() {
    return AnimatedOpacity(
      opacity: _animatedSections['intro']! ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset:
            _animatedSections['intro']! ? Offset.zero : const Offset(0, 0.2),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutQuart,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.red.withOpacity(0.1), width: 1),
          ),
          child: Text(
            "Many fully functional auto-parts are found on Japanese used and new cars, "
            "which are very much in demand as spare parts for the overseas market as well as "
            "in the domestic market. All appropriate car parts are carefully selected by professionals. "
            "You can order all type of Used Car parts, Auto Body Parts, Rebuilt Auto Parts, Refurbished Auto Parts, "
            "Auto Electrical Parts, Engine Parts of all types of makes.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.6,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }

  /// Enhanced "Used Auto Parts from Japan" section with card design
  Widget _buildUsedPartsSection() {
    return AnimatedOpacity(
      opacity: _animatedSections['usedParts']! ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      child: AnimatedScale(
        scale: _animatedSections['usedParts']! ? 1.0 : 0.8,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutQuart,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade50, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(color: Colors.red.withOpacity(0.2), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome, color: Colors.red, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    "Used Auto Parts from Japan",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "We can also assist you with finding auto parts if you need them for the damaged cars "
                "you decide to buy from us. Once these parts are purchased; we can put them into your car "
                "so you don't have to pay shipping for these parts and will receive them together with the car. "
                "RamaDBK is one of the few companies, which offer services listed below.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.6,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Animated Bullet Points Section
  Widget _buildBulletPoints() {
    return Column(
      children: [
        _buildAnimatedBullet(
          "According to your model list we can prepare and dismantle with our experienced professional staff used spare auto parts "
              "for either 20ft or 40 ft container. In addition to dismantling we will also load the used parts into container and arrange "
              "the shipment so you don't have to worry about making any of the shipping arrangements.",
          'bullet1',
          Icons.build,
        ),
        const SizedBox(height: 24),
        _buildAnimatedBullet(
          "You can send your team (usually 2 persons) to our dismantling yard so they could inspect and dismantle the cars on their own "
              "and assure the quality level you are satisfied with. We can assist your staff with necessary VISA support and will provide a "
              "place to live during their stay.",
          'bullet2',
          Icons.people,
        ),
      ],
    );
  }

  /// Single animated bullet with icon
  Widget _buildAnimatedBullet(String text, String animationKey, IconData icon) {
    return AnimatedOpacity(
      opacity: _animatedSections[animationKey]! ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset:
            _animatedSections[animationKey]!
                ? Offset.zero
                : const Offset(0.2, 0),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutQuart,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(color: Colors.red.withOpacity(0.2), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(icon, color: Colors.red, size: 24),
              ),
              const SizedBox(height: 16),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
