import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;

  const RatingBar({super.key, required this.rating, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: AppTheme.accentColor, size: size),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: size * 0.8,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
      ],
    );
  }
}
