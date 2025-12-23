import 'package:dartz/dartz.dart';
import 'package:location/core/error/failures.dart';
import 'package:location/data/models/place_model.dart';
import 'package:location/domain/entities/place.dart';
import 'package:location/domain/repositories/places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  
  @override
  Future<Either<Failure, List<Place>>> getPlaces(String type, double lat, double lng) async {
    await Future.delayed(const Duration(seconds: 1));
    // Dummy Data
    final places = [
      const PlaceModel(
        id: 1,
        name: "Test Hotel",
        type: "hotel",
        latitude: 11.258,
        longitude: 75.780,
        distance: 2.4,
      ),
      const PlaceModel(
        id: 2,
        name: "Test Tourist Spot",
        type: "tourist",
        latitude: 11.260,
        longitude: 75.790,
        distance: 3.5,
      ),
       const PlaceModel(
        id: 3,
        name: "Test Parking",
        type: "parking",
        latitude: 11.255,
        longitude: 75.770,
        distance: 1.2,
      ),
       const PlaceModel(
        id: 4,
        name: "Test Food",
        type: "food",
        latitude: 11.265,
        longitude: 75.785,
        distance: 0.8,
      )
    ];

    if (type.isNotEmpty) {
      return Right(places.where((element) => element.type == type).toList());
    }
    return Right(places);
  }

  @override
  Future<Either<Failure, bool>> addPlace(Place place) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Right(true);
  }
}
