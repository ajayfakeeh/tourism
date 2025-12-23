import 'package:dartz/dartz.dart';
import 'package:location/core/error/failures.dart';
import 'package:location/domain/entities/place.dart';

abstract class PlacesRepository {
  Future<Either<Failure, List<Place>>> getPlaces(
    String type,
    double lat,
    double lng,
  );
  Future<Either<Failure, bool>> addPlace(Place place);
}
