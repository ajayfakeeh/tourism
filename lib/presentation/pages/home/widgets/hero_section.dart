import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Headed somewhere?',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Eat well on the way.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.subtitleColor,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
