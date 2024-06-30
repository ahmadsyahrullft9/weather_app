import 'package:flutter/material.dart';
import 'adaptive_config.dart';

class AdaptiveLayout extends StatelessWidget {
  final Widget Function(BuildContext context, AdaptiveConfig config) builder;

  const AdaptiveLayout({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      final config =
          AdaptiveConfig(screenWidth: screenWidth, screenHeight: screenHeight);
      return builder(context, config);
    });
  }
}
