import 'package:equatable/equatable.dart';
import 'package:location/domain/entities/place.dart';
import 'package:location/domain/entities/weather.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final Weather? weather;
  final List<Place> allFoodSpots;
  final List<Place> weatherRecommendations;
  final List<String> currentMoodTags;

  const DashboardLoaded({
    this.weather,
    this.allFoodSpots = const [],
    this.weatherRecommendations = const [],
    this.currentMoodTags = const [],
  });

  @override
  List<Object> get props => [
    if (weather != null) weather!,
    allFoodSpots,
    weatherRecommendations,
    currentMoodTags,
  ];
}
