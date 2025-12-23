import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final int id;
  final String name;
  final String type; // hotel, tourist, parking, food
  final double latitude;
  final double longitude;
  final double distance;
  final String? description;
  final String? contact;

  const Place({
    required this.id,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.distance,
    this.description,
    this.contact,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    type,
    latitude,
    longitude,
    distance,
    description,
    contact,
  ];
}
