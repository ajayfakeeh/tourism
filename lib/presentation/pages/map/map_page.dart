import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/di/injector.dart';
import 'package:location/presentation/cubit/map/map_cubit.dart';
import 'package:location/presentation/cubit/map/map_state.dart';
import 'package:location/presentation/pages/map/widgets/map_distance_card.dart';
import 'package:location/presentation/pages/map/widgets/map_search_overlay.dart';

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

  void _onLocationSelected() {
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
    }
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
                if (widget.isSelecting)
                  MapSearchOverlay(
                    searchController: _searchController,
                    onSelectLocation: _onLocationSelected,
                  )
                else if (state.distance != null)
                  MapDistanceCard(distance: state.distance!),
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
