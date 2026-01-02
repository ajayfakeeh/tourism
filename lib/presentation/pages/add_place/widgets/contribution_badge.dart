import 'package:flutter/material.dart';

class ContributionBadge extends StatelessWidget {
  const ContributionBadge({super.key});

  @override
  Widget build(BuildContext context) {
    const lightGreen = Color(0xFFE8F5E9);

    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'NEW CONTRIBUTION',
        style: TextStyle(
          color: Color(0xFF2E7D32),
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }
}
