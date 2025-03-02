import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Glowing Hexagons Animation Widget
///
/// Creates an animated background with a hexagonal grid pattern
/// featuring glowing red edges on a dark background, similar to a tech/digital theme.

class GlowingHexagonsAnimation extends StatefulWidget {
  final Color glowColor;
  final Color backgroundColor;
  final double intensity;
  
  const GlowingHexagonsAnimation({
    super.key,
    this.glowColor = const Color(0xFFFF2D55), // Bright red
    this.backgroundColor = const Color(0xFF120000), // Very dark red/black
    this.intensity = 1.0,
  });

  @override
  State<GlowingHexagonsAnimation> createState() => _GlowingHexagonsAnimationState();
}

class _GlowingHexagonsAnimationState extends State<GlowingHexagonsAnimation> with TickerProviderStateMixin {
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
      duration: const Duration(seconds: 3),
    );
    
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    
    // Set up animations
    _pulseAnimation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
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
    const double hexSize = 0.085; // Size of each hexagon
    const double horizontalSpacing = hexSize * 1.75; // Horizontal spacing between hexagons
    const double verticalSpacing = hexSize * 1.5; // Vertical spacing between hexagons
    
    // Calculate number of columns and rows based on screen
    const int cols = 19; // Number of columns in grid
    const int rows = 11; // Number of rows in grid
    
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        // Calculate position with offset for every other row
        final double x = col * horizontalSpacing + (row % 2 == 0 ? 0 : horizontalSpacing / 2) - 0.8;
        final double y = row * verticalSpacing - 0.8;
        
        // Slight position variation for more natural look
        final double offsetX = (math.Random().nextDouble() - 0.5) * 0.02;
        final double offsetY = (math.Random().nextDouble() - 0.5) * 0.02;
        
        _hexPoints.add(HexPoint(
          position: Offset(x + offsetX, y + offsetY),
          size: hexSize * (0.9 + math.Random().nextDouble() * 0.2), // Slight size variation
          phase: math.Random().nextDouble() * 2 * math.pi, // Random starting phase
          pulseIntensity: 0.7 + math.Random().nextDouble() * 0.6, // Random pulse intensity
        ));
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
      animation: Listenable.merge([
        _pulseAnimation,
        _waveAnimation,
      ]),
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
    // Fill background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );
    
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double maxDimension = math.max(size.width, size.height);
    final double scale = maxDimension * 0.6; // Scale the pattern to fill the screen
    
    // Draw all hexagons
    for (final point in hexPoints) {
      final x = centerX + (point.position.dx * scale);
      final y = centerY + (point.position.dy * scale);
      
      // Calculate brightness based on wave position and pulse
      final waveEffect = math.sin(wave + point.phase + time * 0.5);
      final brightness = 0.5 + (waveEffect * 0.25 * point.pulseIntensity) + (pulse * 0.25);
      
      final effectiveIntensity = intensity * brightness.clamp(0.2, 1.0);
      
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
  
  void _drawGlowingHexagon(Canvas canvas, double x, double y, double size, Color color, double intensity) {
    // Draw outer glow
    final outerGlowPaint = Paint()
      ..color = color.withOpacity(0.15 * intensity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6.0);
    
    // Draw middle glow
    final middleGlowPaint = Paint()
      ..color = color.withOpacity(0.35 * intensity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0);
    
    // Draw inner bright line
    final linePaint = Paint()
      ..color = color.withOpacity(0.8 * intensity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    
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