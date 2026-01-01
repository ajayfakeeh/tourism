import 'package:location/data/models/trending_spot.dart';

abstract class TrendingState {}

class TrendingInitial extends TrendingState {}

class TrendingLoading extends TrendingState {}

class TrendingLoaded extends TrendingState {
  final List<TrendingSpot> spots;
  TrendingLoaded(this.spots);
}

class TrendingError extends TrendingState {
  final String message;
  TrendingError(this.message);
}
