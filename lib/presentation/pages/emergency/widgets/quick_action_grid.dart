import 'package:flutter/material.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final emergencyItems = [
      {
        'name': 'Ambulance',
        'icon': Icons.medical_services,
        'color': const Color(0xFFE53935),
        'bg': const Color(0xFFFFEBEE),
      }, // Red
      {
        'name': 'Police',
        'icon': Icons.local_police,
        'color': const Color(0xFF1E88E5),
        'bg': const Color(0xFFE3F2FD),
      }, // Blue
      {
        'name': 'Fire',
        'icon': Icons.local_fire_department,
        'color': const Color(0xFFFF8F00),
        'bg': const Color(0xFFFFF8E1),
      }, // Amber
      {
        'name': 'SOS',
        'icon': Icons.sos,
        'color': Colors.white,
        'bg': const Color(0xFFD32F2F),
        'isSolid': true,
      }, // Dark Red Solid
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: emergencyItems.map((item) {
            final isSolid = item['isSolid'] == true;
            final width = (constraints.maxWidth - 36) / 4; // 3 gaps of 12px

            return Container(
              width: width,
              height: width * 1.2,
              decoration: BoxDecoration(
                color: item['bg'] as Color, // Light background
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSolid
                    ? [
                        BoxShadow(
                          color: (item['bg'] as Color).withValues(alpha: 0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : [],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSolid
                              ? Colors.white.withValues(alpha: 0.2)
                              : Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: item['color'] as Color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['name'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: isSolid ? Colors.white : Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
