import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

class HomeHeader extends StatelessWidget {
  final String currentLocation;
  final VoidCallback onTapLocation;

  const HomeHeader({
    super.key,
    required this.currentLocation,
    required this.onTapLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/150?img=5',
          ), // Dummy avatar
        ),
        GestureDetector(
          onTap: onTapLocation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.near_me, color: Colors.green, size: 16),
                const SizedBox(width: 8),
                Text(
                  'To: $currentLocation',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppTheme.subtitleColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications_none,
            color: AppTheme.textColor,
          ),
        ),
      ],
    );
  }
}
