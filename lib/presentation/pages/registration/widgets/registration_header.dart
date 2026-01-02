import 'package:flutter/material.dart';

class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const primaryGreen = Color(0xFF00E676);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create Your',
          style: textTheme.displayMedium?.copyWith(
            fontSize: 28,
            color: Colors.black87,
          ),
        ),
        Text(
          'Account',
          style: textTheme.displayMedium?.copyWith(
            fontSize: 28,
            color: primaryGreen,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Start your tasty journey and discover the best local food spots around you.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
