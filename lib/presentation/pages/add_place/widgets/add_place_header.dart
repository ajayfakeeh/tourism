import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

class AddPlaceHeader extends StatelessWidget {
  const AddPlaceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add New Place',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Help others discover great spots on their journey.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppTheme.subtitleColor),
        ),
      ],
    );
  }
}
