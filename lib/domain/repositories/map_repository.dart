import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/core/error/failures.dart';

abstract class MapRepository {
  Future<Either<Failure, LatLng>> getCurrentLocation();
  Future<Either<Failure, List<LatLng>>> getRoute(LatLng start, LatLng end);
}
