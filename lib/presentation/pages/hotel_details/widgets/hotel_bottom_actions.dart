import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/domain/entities/place.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelBottomActions extends StatelessWidget {
  final Place place;

  const HotelBottomActions({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ActionButton(
              icon: Icons.local_parking,
              label: 'Parking',
              onTap: () {},
            ),
            _ActionButton(
              icon: Icons.video_library,
              label: 'Videos',
              onTap: () {},
            ),
            _ActionButton(icon: Icons.local_cafe, label: 'Cafe', onTap: () {}),
            _ActionButton(
              icon: Icons.directions,
              label: 'Go',
              isPrimary: true,
              onTap: () async {
                final url = Uri.parse(
                  'https://www.google.com/maps/dir/?api=1&destination=${place.latitude},${place.longitude}',
                );
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isPrimary
                  ? AppTheme.primaryColor
                  : AppTheme.backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                if (isPrimary)
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Icon(
              icon,
              color: isPrimary ? Colors.white : AppTheme.textColor,
              size: 24,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isPrimary ? FontWeight.bold : FontWeight.w500,
            color: isPrimary ? AppTheme.primaryColor : AppTheme.subtitleColor,
          ),
        ),
      ],
    );
  }
}
