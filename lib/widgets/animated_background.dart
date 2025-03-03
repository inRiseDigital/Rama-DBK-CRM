import 'package:flutter/material.dart';
import 'glowing_hexagons.dart';

/// Animated Background Widget
///
/// A container for background animations that can be used across the app.
/// Using the glowing hexagons animation with blue on dark blue background,
/// similar to the reference image.

class AnimatedBackground extends StatelessWidget {
  final Widget child;
  final bool showAnimation;
  final Color glowColor;
  final double intensity;

  const AnimatedBackground({
    super.key,
    required this.child,
    this.showAnimation = true,
    this.glowColor = const Color(0xFF4F95FF), // Bright blue glow
    this.intensity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF040E28), // Dark blue background
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background animations
          if (showAnimation)
            Positioned.fill(
              child: GlowingHexagonsAnimation(
                glowColor: glowColor,
                intensity: intensity,
              ),
            ),

          // Content
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
