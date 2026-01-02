import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

class SplashText extends StatelessWidget {
  final Animation<double> opacityAnimation;

  const SplashText({super.key, required this.opacityAnimation});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FadeTransition(
      opacity: opacityAnimation,
      child: Column(
        children: [
          Text(
            'Tasty Journey',
            style: textTheme.displayMedium?.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Find the best spots near you',
            style: textTheme.bodyLarge?.copyWith(color: AppTheme.subtitleColor),
          ),
        ],
      ),
    );
  }
}
