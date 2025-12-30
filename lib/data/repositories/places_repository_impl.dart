import 'package:dartz/dartz.dart';
import 'package:location/core/error/failures.dart';
import 'package:location/data/models/place_model.dart';
import 'package:location/domain/entities/place.dart';
import 'package:location/domain/entities/review.dart';
import 'package:location/domain/repositories/places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  @override
  Future<Either<Failure, List<Place>>> getPlaces(
    String type,
    double lat,
    double lng,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    // Dummy Data
    final places = [
      const PlaceModel(
        id: 1,
        name: "Grand Hotel",
        type: "hotel",
        latitude: 11.258,
        longitude: 75.780,
        distance: 2.4,
        rating: 4.5,
        imageUrl:
            "https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80",
        description:
            "Experience luxury at its finest with our world-class amenities and services.",
        reviews: [
          Review(
            userName: 'John Doe',
            rating: 5.0,
            comment: 'Excellent service!',
          ),
          Review(
            userName: 'Jane Smith',
            rating: 4.0,
            comment: 'Great location but room service was slow.',
          ),
        ],
        tags: ['pool', 'luxury', 'view'],
      ),
      const PlaceModel(
        id: 5,
        name: "Budget Stay",
        type: "hotel",
        latitude: 11.250,
        longitude: 75.775,
        distance: 5.0,
        rating: 3.5,
        imageUrl:
            "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80",
        description:
            "Affordable and comfortable stay for travelers on a budget.",
        reviews: [
          Review(
            userName: 'Mike Ross',
            rating: 3.0,
            comment: 'Okay for the price.',
          ),
        ],
        tags: ['cheap', 'sleep'],
      ),
      const PlaceModel(
        id: 2,
        name: "City Museum",
        type: "tourist",
        latitude: 11.260,
        longitude: 75.790,
        distance: 3.5,
        tags: ['history', 'indoor'],
      ),
      const PlaceModel(
        id: 3,
        name: "Central Parking",
        type: "parking",
        latitude: 11.255,
        longitude: 75.770,
        distance: 1.2,
        tags: ['parking'],
      ),
      const PlaceModel(
        id: 4,
        name: "Spicy Treats",
        type: "food",
        latitude: 11.265,
        longitude: 75.785,
        distance: 0.8,
        tags: [
          'spicy',
          'food',
          'hot_beverage',
          'cozy',
          'indoor',
        ], // Good for rain
      ),
      const PlaceModel(
        id: 6,
        name: "Tea Valley",
        type: "food",
        latitude: 11.270,
        longitude: 75.780,
        distance: 1.5,
        rating: 4.8,
        imageUrl:
            "https://images.unsplash.com/photo-1544787219-7f47ccb76574?ixlib=rb-4.0.3&auto=format&fit=crop&w=1021&q=80",
        description: "Best tea in town with a view.",
        tags: ['tea', 'hot_beverage', 'cozy', 'view', 'indoor'],
      ),
      const PlaceModel(
        id: 7,
        name: "Cool Scoops",
        type: "food",
        latitude: 11.275,
        longitude: 75.785,
        distance: 0.5,
        rating: 4.2,
        imageUrl:
            "https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?ixlib=rb-4.0.3&auto=format&fit=crop&w=987&q=80",
        description: "Delicious ice creams for sunny days.",
        tags: ['ice_cream', 'cold_beverage', 'outdoor', 'sunny'],
      ),
    ];

    // Sort by distance ascending
    final sortedPlaces = List<Place>.from(places)
      ..sort((a, b) => a.distance.compareTo(b.distance));

    if (type.isNotEmpty) {
      return Right(
        sortedPlaces.where((element) => element.type == type).toList(),
      );
    }
    return Right(sortedPlaces);
  }

  @override
  Future<Either<Failure, bool>> addPlace(Place place) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Right(true);
  }
}
