import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/presentation/cubit/dashboard/dashboard_cubit.dart';
import 'package:location/presentation/pages/map_page.dart';
import 'package:location/presentation/pages/places_page.dart';
import 'package:location/presentation/pages/add_place_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: BlocProvider(
        create: (context) => DashboardCubit()..loadDashboard(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _DashboardButton(
                icon: Icons.hotel,
                label: 'Hotels',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PlacesPage(type: 'hotel'),
                  ),
                ),
              ),
              _DashboardButton(
                icon: Icons.landscape,
                label: 'Tourist Places',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PlacesPage(type: 'tourist'),
                  ),
                ),
              ),
              _DashboardButton(
                icon: Icons.local_parking,
                label: 'Parking',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PlacesPage(type: 'parking'),
                  ),
                ),
              ),
              _DashboardButton(
                icon: Icons.restaurant,
                label: 'Food',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PlacesPage(type: 'food'),
                  ),
                ),
              ),
              _DashboardButton(
                icon: Icons.map,
                label: 'Track Location',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MapPage()),
                ),
              ),
              _DashboardButton(
                icon: Icons.add_location,
                label: 'Add Place',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddPlacePage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DashboardButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
