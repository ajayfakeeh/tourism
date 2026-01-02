import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/domain/entities/place.dart';

class HotelDescription extends StatelessWidget {
  final Place place;

  const HotelDescription({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          place.description ?? "No description available.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.5,
            color: AppTheme.textColor.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
