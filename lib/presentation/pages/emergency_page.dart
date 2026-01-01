import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                'Emergency',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppTheme.textColor,
                  fontSize: 28,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Assist',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.subtitleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _EmergencyGrid(),
                  const SizedBox(height: 32),
                  const _SectionHeader(
                    title: 'Medical Services',
                    icon: Icons.local_hospital_outlined,
                  ),
                  const SizedBox(height: 16),
                  _ServiceList(
                    items: [
                      {
                        'name': 'City General Hospital',
                        'type': 'Hospital',
                        'distance': '1.2 km',
                        'status': 'Open 24/7',
                        'icon': Icons.local_hospital,
                        'color': Colors.redAccent,
                        'actions': ['Call', 'Map'],
                      },
                      {
                        'name': 'LifeCare Pharmacy',
                        'type': 'Pharmacy',
                        'distance': '0.5 km',
                        'status': 'Open until 11 PM',
                        'icon': Icons.local_pharmacy,
                        'color': Colors.teal,
                        'actions': ['Call'],
                      },
                    ],
                  ),
                  const SizedBox(height: 32),
                  const _SectionHeader(
                    title: 'Transport & Travel',
                    icon: Icons.commute_outlined,
                  ),
                  const SizedBox(height: 16),
                  _ServiceList(
                    items: [
                      {
                        'name': 'City Taxi Service',
                        'type': 'Taxi',
                        'distance': '5 min away',
                        'status': 'Available Now',
                        'icon': Icons.local_taxi,
                        'color': Colors.amber.shade700,
                        'actions': ['Call'],
                      },
                      {
                        'name': 'Central Bus Station',
                        'type': 'Bus',
                        'distance': '2.0 km',
                        'status': 'Next bus: 10:45 AM',
                        'icon': Icons.directions_bus,
                        'color': Colors.blueAccent,
                        'actions': ['Schedule'],
                      },
                      {
                        'name': 'Metro Station',
                        'type': 'Train',
                        'distance': '3.2 km',
                        'status': 'Running on time',
                        'icon': Icons.train,
                        'color': Colors.indigo,
                        'actions': ['Map'],
                      },
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppTheme.primaryColor, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class _EmergencyGrid extends StatelessWidget {
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
                          color: (item['bg'] as Color).withOpacity(0.4),
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
                              ? Colors.white.withOpacity(0.2)
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

class _ServiceList extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const _ServiceList({required this.items});

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
                color: Colors.black.withOpacity(0.04),
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
                      color: (item['color'] as Color).withOpacity(0.1),
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
                            color: Colors.green.withOpacity(0.1),
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
