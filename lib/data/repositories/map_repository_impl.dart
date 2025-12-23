import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/core/error/failures.dart';
import 'package:location/core/location/location_service.dart';
import 'package:location/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final LocationService locationService;

  MapRepositoryImpl({required this.locationService});

  @override
  Future<Either<Failure, LatLng>> getCurrentLocation() async {
    try {
      final position = await locationService.getCurrentLocation();
      return Right(LatLng(position.latitude, position.longitude));
    } catch (e) {
      return Left(LocationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LatLng>>> getRoute(
    LatLng start,
    LatLng end,
  ) async {
    // Mocking a route with a few points between start and end because we don't have Directions API
    await Future.delayed(const Duration(seconds: 1));
    return Right([
      start,
      LatLng(
        (start.latitude + end.latitude) / 2,
        (start.longitude + end.longitude) / 2,
      ),
      end,
    ]);
  }
}
