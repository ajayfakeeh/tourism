import 'package:flutter/material.dart';
import 'package:location/core/theme/app_theme.dart';
import 'package:location/presentation/pages/emergency/widgets/emergency_header.dart';
import 'package:location/presentation/pages/emergency/widgets/emergency_section_header.dart';
import 'package:location/presentation/pages/emergency/widgets/emergency_service_list.dart';
import 'package:location/presentation/pages/emergency/widgets/quick_action_grid.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          const EmergencyHeader(),
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
                  const QuickActionGrid(),
                  const SizedBox(height: 32),
                  const EmergencySectionHeader(
                    title: 'Medical Services',
                    icon: Icons.local_hospital_outlined,
                  ),
                  const SizedBox(height: 16),
                  const EmergencyServiceList(
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
                  const EmergencySectionHeader(
                    title: 'Transport & Travel',
                    icon: Icons.commute_outlined,
                  ),
                  const SizedBox(height: 16),
                  const EmergencyServiceList(
                    items: [
                      {
                        'name': 'City Taxi Service',
                        'type': 'Taxi',
                        'distance': '5 min away',
                        'status': 'Available Now',
                        'icon': Icons.local_taxi,
                        'color': Color(0xFFFFA000), // Amber.shade700
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
