import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Primary green color from the design
    const primaryGreen = Color(0xFF00E676);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: 60),
        // Header Icon
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.rice_bowl, color: primaryGreen, size: 32),
          ),
        ),
        const SizedBox(height: 24),
        // Titles
        Text(
          'Welcome Back',
          textAlign: TextAlign.center,
          style: textTheme.displayMedium?.copyWith(
            fontSize: 28, // Slight override if needed, but keeping theme font
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Continue your journey with great food',
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(color: AppTheme.subtitleColor),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
