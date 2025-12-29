import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/domain/repositories/map_repository.dart';
import 'package:location/presentation/cubit/map/map_state.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapCubit extends Cubit<MapState> {
  final MapRepository mapRepository;

  MapCubit({required this.mapRepository}) : super(MapInitial());

  Future<void> loadCurrentLocation() async {
    emit(MapLoading());
    final result = await mapRepository.getCurrentLocation();
    result.fold((failure) => emit(MapError(failure.message)), (location) {
      emit(
        MapLoaded(
          currentLocation: location,
          markers: {
            Marker(
              markerId: const MarkerId('current'),
              position: location,
              infoWindow: const InfoWindow(title: 'Current Location'),
            ),
          },
          polylines: {},
        ),
      );
    });
  }

  Future<void> setDestination(LatLng destination) async {
    final currentState = state;
    if (currentState is MapLoaded) {
      final start = currentState.currentLocation;

      // Calculate distance
      final distanceInMeters = Geolocator.distanceBetween(
        start.latitude,
        start.longitude,
        destination.latitude,
        destination.longitude,
      );

      // Get Route (Mocked)
      final routeResult = await mapRepository.getRoute(start, destination);

      routeResult.fold((failure) => emit(MapError(failure.message)), (
        routePoints,
      ) {
        final markers = Set<Marker>.from(currentState.markers);
        markers.add(
          Marker(
            markerId: const MarkerId('destination'),
            position: destination,
            infoWindow: const InfoWindow(title: 'Destination'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
          ),
        );

        final polylines = {
          Polyline(
            polylineId: const PolylineId('route'),
            points: routePoints,
            color: Colors.blue,
            width: 5,
          ),
        };

        emit(
          currentState.copyWith(
            destination: destination,
            markers: markers,
            polylines: polylines,
            distance: distanceInMeters / 1000, // Convert to KM
          ),
        );
      });
    }
  }

  Future<void> openGoogleMaps() async {
    final currentState = state;
    if (currentState is MapLoaded && currentState.destination != null) {
      final url =
          'https://www.google.com/maps/dir/?api=1&origin=${currentState.currentLocation.latitude},${currentState.currentLocation.longitude}&destination=${currentState.destination!.latitude},${currentState.destination!.longitude}';
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      }
    }
  }

  Future<void> searchLocation(String query) async {
    // Mock Search Implementation
    emit(MapLoading());
    await Future.delayed(const Duration(seconds: 1)); // Simulate API delay

    // For demo: Always find "Osaka Castle" or similar mock location if query is not empty
    const mockLocation = LatLng(34.6873, 135.5262); // Osaka Castle Coords

    final currentState = state;
    if (currentState is MapLoaded) {
      // It should be loaded to search
      emit(
        currentState.copyWith(
          currentLocation:
              mockLocation, // Move "current" or center to search result for demo
          markers: {
            Marker(
              markerId: const MarkerId('searched'),
              position: mockLocation,
              infoWindow: InfoWindow(title: query),
            ),
          },
        ),
      );
    } else {
      // Fallback if somehow not loaded
      emit(
        MapLoaded(
          currentLocation: mockLocation,
          markers: {
            Marker(
              markerId: const MarkerId('searched'),
              position: mockLocation,
              infoWindow: InfoWindow(title: query),
            ),
          },
          polylines: {},
        ),
      );
    }
  }
}
