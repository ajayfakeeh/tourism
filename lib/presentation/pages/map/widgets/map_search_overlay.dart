import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/presentation/cubit/map/map_cubit.dart';
import 'package:location/presentation/cubit/map/map_state.dart';

class MapSearchOverlay extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSelectLocation;

  const MapSearchOverlay({
    super.key,
    required this.searchController,
    required this.onSelectLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search location...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (searchController.text.isNotEmpty) {
                      context.read<MapCubit>().searchLocation(
                        searchController.text,
                      );
                    }
                  },
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  context.read<MapCubit>().searchLocation(value);
                }
              },
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              final currentState = context.read<MapCubit>().state;
              LatLng? selectedLocation;
              if (currentState is MapLoaded) {
                selectedLocation = currentState.currentLocation;
              }

              if (selectedLocation != null) {
                onSelectLocation();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please wait for map to load')),
                );
              }
            },
            child: const Text(
              'Select This Location',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
