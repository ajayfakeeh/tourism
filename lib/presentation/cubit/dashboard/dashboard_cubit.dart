import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/presentation/cubit/dashboard/dashboard_state.dart';

import 'package:location/data/datasources/mock_weather_service.dart';
import 'package:location/data/datasources/weather_mood_mapper.dart';
import 'package:location/data/repositories/places_repository_impl.dart';
import 'package:location/domain/entities/place.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final _weatherService = MockWeatherService();
  final _placesRepository =
      PlacesRepositoryImpl(); // Using impl directly for now

  DashboardCubit() : super(DashboardInitial());

  Future<void> loadDashboard() async {
    emit(DashboardLoading());

    try {
      // 1. Fetch Weather
      final weather = await _weatherService.getCurrentWeather();

      // 2. Fetch All Places (simulating logic to get broad set of places)
      // fetching 'food' specifically as per requirement
      final foodResult = await _placesRepository.getPlaces('food', 0, 0);
      final hotelResult = await _placesRepository.getPlaces('hotel', 0, 0);

      List<Place> allFoodSpots = [];
      foodResult.fold(
        (l) => print('Error fetching food: $l'),
        (r) => allFoodSpots.addAll(r),
      );

      hotelResult.fold(
        (l) => print('Error fetching hotels: $l'),
        (r) => allFoodSpots.addAll(
          r,
        ), // Merging hotels into food spots list for now? User said "restaurants" but mentioned hotels.
        // Let's keep them somewhat separate or merge if "eating places".
        // For "Food Spots on your way", let's show `allFoodSpots` (food only).
      );

      // Let's reset and just fetch 'food' for "Food Spots" list.
      // And for "Mood" list, we check ALL places (Food + Hotels + Tourist?) or just Food?
      // User said "under food spots... shows the hotels based on weather".
      // I will fetch 'food' and 'hotel' and combine them for filtering.

      final allPlacesResult = await _placesRepository.getPlaces(
        '',
        0,
        0,
      ); // Get all
      List<Place> allPlaces = [];
      allPlacesResult.fold((l) => null, (r) => allPlaces = r);

      // 3. Determine Mood Tags
      final moodTags = WeatherMoodMapper.getTagsForWeather(weather);

      // 4. Filter Recommendations
      final recommendations = allPlaces.where((place) {
        // specific food spots or hotels that match tags
        return place.tags.any((tag) => moodTags.contains(tag));
      }).toList();

      // 5. Get specifically "Food Spots" for the general list
      final foodSpots = allPlaces.where((p) => p.type == 'food').toList();

      emit(
        DashboardLoaded(
          weather: weather,
          allFoodSpots: foodSpots,
          weatherRecommendations: recommendations,
          currentMoodTags: moodTags,
        ),
      );
    } catch (e) {
      print("Error loading dashboard: $e");
      // In a real app, emit DashboardError
      emit(DashboardLoaded()); // Fallback
    }
  }
}
