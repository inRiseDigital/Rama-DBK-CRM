import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Glowing Hexagons Animation Widget
///
/// Creates an animated background with a hexagonal grid pattern
/// featuring glowing blue edges on a dark blue background, similar to the reference image.

class GlowingHexagonsAnimation extends StatefulWidget {
  final Color glowColor;
  final Color backgroundColor;
  final double intensity;

  const GlowingHexagonsAnimation({
    super.key,
    this.glowColor = const Color(0xFF4F95FF), // Bright blue glow
    this.backgroundColor = const Color(0xFF040E28), // Dark blue background
    this.intensity = 1.0,
  });

  @override
  State<GlowingHexagonsAnimation> createState() =>
      _GlowingHexagonsAnimationState();
}

class _GlowingHexagonsAnimationState extends State<GlowingHexagonsAnimation>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _waveController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;

  final List<HexPoint> _hexPoints = [];

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ), // Slower pulse for more subtle effect
    );

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 12,
      ), // Slower wave for more subtle effect
    );

    // Set up animations
    _pulseAnimation = Tween<double>(
      begin: 0.6, // Higher minimum brightness
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _waveAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(_waveController);

    // Start animations
    _pulseController.repeat(reverse: true);
    _waveController.repeat();

    // Generate hexagon grid
    _generateHexGrid();
  }

  void _generateHexGrid() {
    const double hexSize = 0.06; // Smaller hexagons for more dense grid
    const double horizontalSpacing = hexSize * 1.75;
    const double verticalSpacing = hexSize * 1.5;

    // More columns and rows for denser grid
    const int cols = 25;
    const int rows = 15;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        // Calculate position with offset for every other row
        final double x =
            col * horizontalSpacing +
            (row % 2 == 0 ? 0 : horizontalSpacing / 2) -
            0.8;
        final double y = row * verticalSpacing - 0.8;

        // Minimal position variation for more regular pattern
        final double offsetX = (math.Random().nextDouble() - 0.5) * 0.01;
        final double offsetY = (math.Random().nextDouble() - 0.5) * 0.01;

        _hexPoints.add(
          HexPoint(
            position: Offset(x + offsetX, y + offsetY),
            size:
                hexSize *
                (0.95 +
                    math.Random().nextDouble() * 0.1), // Less size variation
            phase:
                math.Random().nextDouble() *
                2 *
                math.pi, // Random starting phase
            pulseIntensity:
                0.8 +
                math.Random().nextDouble() * 0.4, // Subtle pulse variation
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseAnimation, _waveAnimation]),
      builder: (context, child) {
        return CustomPaint(
          painter: GlowingHexagonsPainter(
            glowColor: widget.glowColor,
            backgroundColor: widget.backgroundColor,
            pulse: _pulseAnimation.value,
            wave: _waveAnimation.value,
            hexPoints: _hexPoints,
            intensity: widget.intensity,
            time: DateTime.now().millisecondsSinceEpoch / 1000,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class GlowingHexagonsPainter extends CustomPainter {
  final Color glowColor;
  final Color backgroundColor;
  final double pulse;
  final double wave;
  final List<HexPoint> hexPoints;
  final double intensity;
  final double time;

  GlowingHexagonsPainter({
    required this.glowColor,
    required this.backgroundColor,
    required this.pulse,
    required this.wave,
    required this.hexPoints,
    required this.intensity,
    required this.time,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Fill background with gradient
    final Rect fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint bgPaint =
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(0.0, 0.0),
            radius: 1.0,
            colors: [
              const Color(0xFF081642), // Slightly lighter center
              backgroundColor, // Darker edges
            ],
            stops: const [0.3, 1.0],
          ).createShader(fullRect);

    canvas.drawRect(fullRect, bgPaint);

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double maxDimension = math.max(size.width, size.height);
    final double scale = maxDimension * 0.55; // Scale to fill the screen

    // Draw all hexagons
    for (final point in hexPoints) {
      final x = centerX + (point.position.dx * scale);
      final y = centerY + (point.position.dy * scale);

      // Calculate brightness based on wave position and pulse
      final waveEffect = math.sin(
        wave + point.phase + time * 0.3,
      ); // Slower time factor
      final brightness =
          0.7 + (waveEffect * 0.15 * point.pulseIntensity) + (pulse * 0.15);

      final effectiveIntensity = intensity * brightness.clamp(0.4, 1.0);

      _drawGlowingHexagon(
        canvas,
        x,
        y,
        point.size * scale,
        glowColor,
        effectiveIntensity,
      );
    }
  }

  void _drawGlowingHexagon(
    Canvas canvas,
    double x,
    double y,
    double size,
    Color color,
    double intensity,
  ) {
    // Draw outer glow
    final outerGlowPaint =
        Paint()
          ..color = color.withOpacity(0.12 * intensity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);

    // Draw middle glow
    final middleGlowPaint =
        Paint()
          ..color = color.withOpacity(0.25 * intensity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

    // Draw inner bright line
    final linePaint =
        Paint()
          ..color = color.withOpacity(0.9 * intensity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8;

    // Create hexagon path
    final path = _createHexagonPath(x, y, size);

    // Draw layers
    canvas.drawPath(path, outerGlowPaint);
    canvas.drawPath(path, middleGlowPaint);
    canvas.drawPath(path, linePaint);
  }

  Path _createHexagonPath(double x, double y, double size) {
    final path = Path();

    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 * math.pi / 180);
      final double pointX = x + size * math.cos(angle);
      final double pointY = y + size * math.sin(angle);

      if (i == 0) {
        path.moveTo(pointX, pointY);
      } else {
        path.lineTo(pointX, pointY);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(GlowingHexagonsPainter oldDelegate) {
    return oldDelegate.pulse != pulse ||
        oldDelegate.wave != wave ||
        oldDelegate.time != time;
  }
}

class HexPoint {
  final Offset position;
  final double size;
  final double phase;
  final double pulseIntensity;

  HexPoint({
    required this.position,
    required this.size,
    required this.phase,
    required this.pulseIntensity,
  });
}
