import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/di/injector.dart';
import 'package:location/presentation/cubit/map/map_cubit.dart';
import 'package:location/presentation/cubit/map/map_state.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MapCubit>()..loadCurrentLocation(),
      child: const MapView(),
    );
  }
}

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {
          if (state is MapError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is MapLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MapLoaded) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: state.currentLocation,
                    zoom: 14,
                  ),
                  markers: state.markers,
                  polylines: state.polylines,
                  onLongPress: (latLng) {
                    context.read<MapCubit>().setDestination(latLng);
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                if (state.distance != null)
                  Positioned(
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
                              'Distance: ${state.distance!.toStringAsFixed(2)} km',
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
                  ),
              ],
            );
          }
          return const Center(child: Text('Initialize Map...'));
        },
      ),
      floatingActionButton: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<MapCubit>().loadCurrentLocation();
            },
            child: const Icon(Icons.my_location),
          );
        },
      ),
    );
  }
}
