import 'package:equatable/equatable.dart';
import 'package:location/domain/entities/review.dart';

class Place extends Equatable {
  final int id;
  final String name;
  final String type; // hotel, tourist, parking, food
  final double latitude;
  final double longitude;
  final double distance;
  final String? description;
  final String? contact;
  final double? rating;
  final String? imageUrl;
  final List<Review>? reviews;

  const Place({
    required this.id,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.distance,
    this.description,
    this.contact,
    this.rating,
    this.imageUrl,
    this.reviews,
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
    rating,
    imageUrl,
    reviews,
  ];
}
