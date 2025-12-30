import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/presentation/cubit/home/home_state.dart';
import 'package:location/data/datasources/mock_weather_service.dart';
import 'package:location/data/datasources/weather_mood_mapper.dart';

class HomeCubit extends Cubit<HomeState> {
  final _weatherService = MockWeatherService();

  HomeCubit() : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock Data (Moved from HomePage)
      final foodSpotsOnWay = [
        {
          'name': 'Ramen Nagi',
          'image':
              'https://plus.unsplash.com/premium_photo-1664472637341-3ec829d1f4df?q=80&w=2525&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'rating': 4.8,
          'cuisine': 'Japanese',
          'price': '\$\$',
          'distance': '12 km away',
          'detour': '2 min detour',
          'tags': ['cozy', 'hot_beverage'],
        },
        {
          'name': 'El Pueblo',
          'image':
              'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=2487&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'rating': 4.6,
          'cuisine': 'Mexican',
          'price': '\$\$',
          'distance': '18 km away',
          'detour': '5 min detour',
          'tags': ['spicy'],
        },
      ];

      // Additional data specifically for weather recommendations
      final extraPlaces = [
        {
          'name': 'Spicy Treats',
          'image':
              'https://images.unsplash.com/photo-1596797038530-2c107229654b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1035&q=80',
          'rating': 4.7,
          'cuisine': 'Indian',
          'price': '\$',
          'distance': '5 km away',
          'detour': '1 min detour',
          'tags': ['spicy', 'hot_beverage', 'cozy'],
        },
        {
          'name': 'Tea Valley',
          'image':
              'https://images.unsplash.com/photo-1544787219-7f47ccb76574?ixlib=rb-4.0.3&auto=format&fit=crop&w=1021&q=80',
          'rating': 4.9,
          'cuisine': 'Cafe',
          'price': '\$',
          'distance': '2 km away',
          'detour': '5 min detour',
          'tags': ['tea', 'hot_beverage', 'cozy', 'view'],
        },
        {
          'name': 'Cool Scoops',
          'image':
              'https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?ixlib=rb-4.0.3&auto=format&fit=crop&w=987&q=80',
          'rating': 4.5,
          'cuisine': 'Dessert',
          'price': '\$',
          'distance': '1 km away',
          'detour': '0 min detour',
          'tags': ['ice_cream', 'cold_beverage', 'outdoor', 'sunny'],
        },
      ];

      final forgotToSave = [
        {
          'name': 'Bamboo Burger',
          'subtitle': 'You passed earlier',
          'image':
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=2598&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        },
        {
          'name': 'Sushi Place',
          'subtitle': 'Popular spot',
          'image':
              'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        },
      ];

      final justBeforeArrive = [
        {
          'name': 'Matcha House',
          'image':
              'https://images.unsplash.com/photo-1556742400-b5b7c5121f99?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'rating': 4.9,
          'distance': '5km',
        },
        {
          'name': 'Osaka Grill',
          'image':
              'https://images.unsplash.com/photo-1514326640560-7d063ef2aed5?q=80&w=2680&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'rating': 4.7,
          'distance': '6km',
        },
      ];

      final nearDestination = [
        {
          'id': '1',
          'name': 'Castle View Cafe',
          'image':
              'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'rating': 4.6,
          'category': 'Cafe',
          'categoryId': '1',
          'distance': '0.2 km from dest',
        },
        {
          'id': '2',
          'name': 'Osaka Bay View',
          'image':
              'https://images.unsplash.com/photo-1516216628259-9474d32d7271?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'rating': 4.8,
          'category': 'Viewpoint',
          'categoryId': '2',
          'distance': '1.5 km from dest',
        },
        {
          'id': '3',
          'name': 'Sunny Beach',
          'image':
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=2673&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'rating': 4.5,
          'category': 'Beach',
          'categoryId': '3',
          'distance': '5 km from dest',
        },
        {
          'id': '4',
          'name': 'Grand Hotel',
          'image':
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'rating': 4.9,
          'category': 'Hotel',
          'categoryId': '4',
          'distance': '0.5 km from dest',
        },
      ];

      final categories = [
        {'id': 'all', 'name': 'All'},
        {'id': '2', 'name': 'Viewpoints'},
        {'id': '3', 'name': 'Beaches'},
        {'id': '4', 'name': 'Hotels'},
      ];

      // Fetch Weather logic
      final weatherEntity = await _weatherService.getCurrentWeather();
      final weatherMap = {
        'temperature': '${weatherEntity.temperature.toStringAsFixed(0)}°C',
        'condition': weatherEntity.condition,
        'icon': weatherEntity.condition.toLowerCase().contains('rain')
            ? 'cloud'
            : 'sunny',
      };

      // Determine Mood
      final moodTags = WeatherMoodMapper.getTagsForWeather(weatherEntity);

      // Filter Recommendations
      final allPlaces = [...foodSpotsOnWay, ...extraPlaces];
      final weatherRecommendations = allPlaces.where((place) {
        final tags = place['tags'] as List<String>? ?? [];
        return tags.any((tag) => moodTags.contains(tag));
      }).toList();

      emit(
        HomeLoaded(
          foodSpotsOnWay: foodSpotsOnWay,
          forgotToSave: forgotToSave,
          justBeforeArrive: justBeforeArrive,
          nearDestination: nearDestination,
          currentLocation: 'Osaka Castle',
          categories: categories,
          selectedCategoryId: 'all',
          weather: weatherMap,
          weatherRecommendations: weatherRecommendations,
        ),
      );
    } catch (e) {
      emit(HomeError('Failed to load data: $e'));
    }
  }

  void toggleForecastVisibility() {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final newVisibility = !currentState.isForecastVisible;

      emit(
        HomeLoaded(
          foodSpotsOnWay: currentState.foodSpotsOnWay,
          forgotToSave: currentState.forgotToSave,
          justBeforeArrive: currentState.justBeforeArrive,
          nearDestination: currentState.nearDestination,
          currentLocation: currentState.currentLocation,
          categories: currentState.categories,
          selectedCategoryId: currentState.selectedCategoryId,
          weather: currentState.weather,
          forecast: currentState.forecast,
          isForecastLoading: currentState.isForecastLoading,
          isForecastVisible: newVisibility,
        ),
      );

      // Auto-load if becoming visible and empty
      if (newVisibility && currentState.forecast.isEmpty) {
        loadForecast();
      }
    }
  }

  // Load forecast data (Initial or Pagination)
  Future<void> loadForecast() async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      if (currentState.isForecastLoading) return;

      emit(
        HomeLoaded(
          foodSpotsOnWay: currentState.foodSpotsOnWay,
          forgotToSave: currentState.forgotToSave,
          justBeforeArrive: currentState.justBeforeArrive,
          nearDestination: currentState.nearDestination,
          currentLocation: currentState.currentLocation,
          categories: currentState.categories,
          selectedCategoryId: currentState.selectedCategoryId,
          weather: currentState.weather,
          forecast: currentState.forecast,
          isForecastLoading: true,
          isForecastVisible: currentState.isForecastVisible,
        ),
      );

      await Future.delayed(const Duration(seconds: 1)); // Simulate delay

      final currentCount = currentState.forecast.length;
      final now = DateTime.now().add(Duration(days: currentCount));
      final List<Map<String, dynamic>> newItems = [];

      for (int i = 0; i < 7; i++) {
        final date = now.add(Duration(days: i));
        final isSunny = (date.day + i) % 2 == 0;
        newItems.add({
          'date': '${date.day}/${date.month}',
          'dayName': _getDayName(date.weekday),
          'temperature': '${20 + (date.day % 5)}°C',
          'condition': isSunny ? 'Sunny' : 'Cloudy',
          'icon': isSunny ? 'sunny' : 'cloud',
        });
      }

      emit(
        HomeLoaded(
          foodSpotsOnWay: currentState.foodSpotsOnWay,
          forgotToSave: currentState.forgotToSave,
          justBeforeArrive: currentState.justBeforeArrive,
          nearDestination: currentState.nearDestination,
          currentLocation: currentState.currentLocation,
          categories: currentState.categories,
          selectedCategoryId: currentState.selectedCategoryId,
          weather: currentState.weather,
          forecast: [...currentState.forecast, ...newItems],
          isForecastLoading: false,
          isForecastVisible: currentState.isForecastVisible,
        ),
      );
    }
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  void updateLocation(String newLocation) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(
        HomeLoaded(
          foodSpotsOnWay: currentState.foodSpotsOnWay,
          forgotToSave: currentState.forgotToSave,
          justBeforeArrive: currentState.justBeforeArrive,
          nearDestination: currentState.nearDestination,
          currentLocation: newLocation,
          categories: currentState.categories,
          selectedCategoryId: currentState.selectedCategoryId,
          weather: currentState.weather,
          forecast: currentState.forecast,
          isForecastLoading: currentState.isForecastLoading,
          isForecastVisible: currentState.isForecastVisible,
        ),
      );
    }
  }

  void selectCategory(String categoryId) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      // Mock Filtering Logic
      final allDestinations = [
        {
          'id': '1',
          'name': 'Castle View Cafe',
          'image':
              'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'rating': 4.6,
          'category': 'Cafe',
          'categoryId': '1',
          'distance': '0.2 km from dest',
        },
        {
          'id': '2',
          'name': 'Osaka Bay View',
          'image':
              'https://images.unsplash.com/photo-1516216628259-9474d32d7271?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'rating': 4.8,
          'category': 'Viewpoint',
          'categoryId': '2',
          'distance': '1.5 km from dest',
        },
        {
          'id': '3',
          'name': 'Sunny Beach',
          'image':
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=2673&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'rating': 4.5,
          'category': 'Beach',
          'categoryId': '3',
          'distance': '5 km from dest',
        },
        {
          'id': '4',
          'name': 'Grand Hotel',
          'image':
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'rating': 4.9,
          'category': 'Hotel',
          'categoryId': '4',
          'distance': '0.5 km from dest',
        },
      ];

      List<Map<String, dynamic>> filteredList;
      if (categoryId == 'all') {
        filteredList = allDestinations;
      } else {
        filteredList = allDestinations
            .where((item) => item['categoryId'] == categoryId)
            .toList();
      }

      emit(
        HomeLoaded(
          foodSpotsOnWay: currentState.foodSpotsOnWay,
          forgotToSave: currentState.forgotToSave,
          justBeforeArrive: currentState.justBeforeArrive,
          nearDestination: filteredList,
          currentLocation: currentState.currentLocation,
          categories: currentState.categories,
          selectedCategoryId: categoryId,
          weather: currentState.weather,
          forecast: currentState.forecast,
          isForecastLoading: currentState.isForecastLoading,
          isForecastVisible: currentState.isForecastVisible,
        ),
      );
    }
  }
}
