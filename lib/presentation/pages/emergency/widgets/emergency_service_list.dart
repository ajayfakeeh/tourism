import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

class EmergencyServiceList extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const EmergencyServiceList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: (item['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: item['color'] as Color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppTheme.textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              item['type'],
                              style: TextStyle(
                                color: AppTheme.subtitleColor,
                                fontSize: 13,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Icon(
                                Icons.circle,
                                size: 4,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            Text(
                              item['distance'],
                              style: TextStyle(
                                color: AppTheme.subtitleColor,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item['status'],
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(height: 1, color: Colors.grey.shade100),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: (item['actions'] as List<String>).map((action) {
                  final isCall = action == 'Call';
                  return Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isCall
                              ? const Color(0xFFE0F2F1)
                              : Colors.transparent, // Teal 50 for call
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isCall
                                ? Colors.transparent
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isCall
                                  ? Icons.call
                                  : (action == 'Map'
                                        ? Icons.near_me
                                        : Icons.schedule),
                              size: 16,
                              color: isCall
                                  ? AppTheme.primaryColor
                                  : AppTheme.subtitleColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              action,
                              style: TextStyle(
                                color: isCall
                                    ? AppTheme.primaryColor
                                    : AppTheme.subtitleColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
