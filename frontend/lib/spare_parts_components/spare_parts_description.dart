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
    _scrollController.addListener(_checkScroll);

    // Initialize with title visible
    _animatedSections['title'] = true;

    // Delay other animations slightly to create a cascade effect
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _animatedSections['intro'] = true;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _animatedSections['usedParts'] = true;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _animatedSections['bullet1'] = true;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _animatedSections['bullet2'] = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_checkScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Check scroll position to trigger animations
  void _checkScroll() {
    if (!_scrollController.hasClients) return;

    final double scrollPosition = _scrollController.position.pixels;
    final double viewportHeight = _scrollController.position.viewportDimension;
    final double scrollTrigger =
        viewportHeight * 0.75; // Trigger when item is 75% visible

    setState(() {
      _animatedSections['title'] = scrollPosition < viewportHeight * 0.3;
      _animatedSections['intro'] = scrollPosition < viewportHeight * 0.6;
      _animatedSections['usedParts'] = scrollPosition < viewportHeight * 0.9;
      _animatedSections['bullet1'] = scrollPosition > scrollTrigger;
      _animatedSections['bullet2'] = scrollPosition > scrollTrigger + 100;
    });
  }

  /// Main Build
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: Colors.white,
          width: double.infinity,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    _buildTitle(),
                    const SizedBox(height: 60),
                    _buildIntroParagraph(),
                    const SizedBox(height: 60),
                    _buildUsedPartsSection(),
                    const SizedBox(height: 60),
                    _buildBulletPoints(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Title: "Are You Looking for Auto Parts from Japan?"
  Widget _buildTitle() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: AnimatedOpacity(
        opacity: _animatedSections['title']! ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset:
              _animatedSections['title']! ? Offset.zero : const Offset(0, 0.2),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutQuart,
          child: Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Are You Looking for ',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(
                      text: 'Auto Parts',
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                    const TextSpan(text: ' from Japan?'),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                width: _animatedSections['title']! ? 100 : 0,
                height: 3,
                color: Colors.red.shade700,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Intro Paragraph with improved styling
  Widget _buildIntroParagraph() {
    return AnimatedOpacity(
      opacity: _animatedSections['intro']! ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset:
            _animatedSections['intro']! ? Offset.zero : const Offset(0, 0.2),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOutQuart,
        child: Text(
          "Many fully functional auto-parts are found on Japanese used and new cars, "
          "which are very much in demand as spare parts for the overseas market as well as "
          "in the domestic market. All appropriate car parts are carefully selected by professionals. "
          "You can order all type of Used Car parts, Auto Body Parts, Rebuilt Auto Parts, Refurbished Auto Parts, "
          "Auto Electrical Parts, Engine Parts of all types of makes.",
          style: const TextStyle(
            fontSize: 18,
            height: 1.8,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// Enhanced "Used Auto Parts from Japan" section with card design
  Widget _buildUsedPartsSection() {
    return AnimatedOpacity(
      opacity: _animatedSections['usedParts']! ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset:
            _animatedSections['usedParts']!
                ? Offset.zero
                : const Offset(0, 0.2),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOutQuart,
        child: Column(
          children: [
            Text(
              "Used Auto Parts from Japan",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              "We can also assist you with finding auto parts if you need them for the damaged cars "
              "you decide to buy from us. Once these parts are purchased; we can put them into your car "
              "so you don't have to pay shipping for these parts and will receive them together with the car. "
              "RamaDBK is one of the few companies, which offer services listed below.",
              style: const TextStyle(
                fontSize: 18,
                height: 1.8,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Animated Bullet Points Section
  Widget _buildBulletPoints() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAnimatedBullet(
          "According to your model list we can prepare and dismantle with our experienced professional staff used spare auto parts "
              "for either 20ft or 40 ft container. In addition to dismantling we will also load the used parts into container and arrange "
              "the shipment so you don't have to worry about making any of the shipping arrangements.",
          'bullet1',
        ),
        const SizedBox(height: 40),
        _buildAnimatedBullet(
          "You can send your team (usually 2 persons) to our dismantling yard so they could inspect and dismantle the cars on their own "
              "and assure the quality level you are satisfied with. We can assist your staff with necessary VISA support and will provide a "
              "place to live during their stay.",
          'bullet2',
        ),
      ],
    );
  }

  /// Single animated bullet with icon
  Widget _buildAnimatedBullet(String text, String animationKey) {
    return AnimatedOpacity(
      opacity: _animatedSections[animationKey]! ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset:
            _animatedSections[animationKey]!
                ? Offset.zero
                : const Offset(0, 0.2),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOutQuart,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.8,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
