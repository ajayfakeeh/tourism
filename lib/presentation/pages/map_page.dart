import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/di/injector.dart';
import 'package:location/presentation/cubit/map/map_cubit.dart';
import 'package:location/presentation/cubit/map/map_state.dart';

class MapPage extends StatelessWidget {
  final bool isSelecting;

  const MapPage({super.key, this.isSelecting = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MapCubit>()..loadCurrentLocation(),
      child: MapView(isSelecting: isSelecting),
    );
  }
}

class MapView extends StatefulWidget {
  final bool isSelecting;

  const MapView({super.key, required this.isSelecting});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                if (widget.isSelecting) ...[
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
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search location...',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              // Mock Search
                              if (_searchController.text.isNotEmpty) {
                                context.read<MapCubit>().searchLocation(
                                  _searchController.text,
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
                          Navigator.pop(context, {
                            'location': selectedLocation,
                            'name': _searchController.text.isEmpty
                                ? 'Pinned Location'
                                : _searchController.text,
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please wait for map to load'),
                            ),
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
                ] else if (state.distance != null)
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
