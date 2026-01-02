import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/presentation/cubit/map/map_cubit.dart';

class MapDistanceCard extends StatelessWidget {
  final double distance;

  const MapDistanceCard({super.key, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Distance: ${distance.toStringAsFixed(2)} km',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<MapCubit>().openGoogleMaps();
                },
                icon: const Icon(Icons.map),
                label: const Text('Open in Google Maps'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
