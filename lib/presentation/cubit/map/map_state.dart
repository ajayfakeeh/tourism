import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapState extends Equatable {
  const MapState();
  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final LatLng currentLocation;
  final LatLng? destination;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final double? distance;

  const MapLoaded({
    required this.currentLocation,
    this.destination,
    required this.markers,
    required this.polylines,
    this.distance,
  });

  @override
  List<Object?> get props => [
    currentLocation,
    destination,
    markers,
    polylines,
    distance,
  ];

  MapLoaded copyWith({
    LatLng? currentLocation,
    LatLng? destination,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
    double? distance,
  }) {
    return MapLoaded(
      currentLocation: currentLocation ?? this.currentLocation,
      destination: destination ?? this.destination,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      distance: distance ?? this.distance,
    );
  }
}

class MapError extends MapState {
  final String message;
  const MapError(this.message);
  @override
  List<Object> get props => [message];
}
