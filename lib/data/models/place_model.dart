import 'package:location/domain/entities/place.dart';
import 'package:location/domain/entities/review.dart';

class PlaceModel extends Place {
  const PlaceModel({
    required super.id,
    required super.name,
    required super.type,
    required super.latitude,
    required super.longitude,
    required super.distance,
    super.description,
    super.contact,
    super.rating,
    super.imageUrl,
    super.reviews,
    super.tags, // Initialize tags
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      description: json['description'],
      contact: json['contact'],
      rating: (json['rating'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'],
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
      'description': description,
      'contact': contact,
      'rating': rating,
      'imageUrl': imageUrl,
      'reviews': reviews?.map((e) => e.toJson()).toList(),
      'tags': tags,
    };
  }
}
