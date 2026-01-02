import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: 20),
        // Lock Icon
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: Color(0xFFE8F5E9), // Light green background
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.lock,
              size: 48,
              color: Color(0xFF2E7D32), // Darker green for the lock
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Title
        Text(
          'Forgot Password?',
          style: textTheme.displayMedium?.copyWith(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        // Subtitle
        Text(
          'Don\'t worry! It happens. Please enter the email associated with your account.',
          style: textTheme.bodyMedium?.copyWith(
            color: AppTheme.subtitleColor,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
