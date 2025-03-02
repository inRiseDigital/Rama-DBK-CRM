import 'package:flutter/material.dart';
import 'glowing_hexagons.dart';

/// Animated Background Widget
///
/// A container for background animations that can be used across the app.
/// Using the glowing hexagons animation with red on dark background.

class AnimatedBackground extends StatelessWidget {
  final Widget child;
  final bool showAnimation;
  final Color glowColor;
  final double intensity;

  const AnimatedBackground({
    super.key,
    required this.child,
    this.showAnimation = true,
    this.glowColor = const Color(0xFFFF2D55), // Bright red glow
    this.intensity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF120000), // Very dark red/black
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
