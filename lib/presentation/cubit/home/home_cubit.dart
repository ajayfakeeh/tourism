import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/presentation/cubit/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
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

      // Simulate separate Weather API call
      final weather = await _fetchWeatherData();

      emit(
        HomeLoaded(
          foodSpotsOnWay: foodSpotsOnWay,
          forgotToSave: forgotToSave,
          justBeforeArrive: justBeforeArrive,
          nearDestination:
              nearDestination, // Initially show all or default logic? User said "All Food" is a category.
          currentLocation: 'Osaka Castle',
          categories: categories,
          selectedCategoryId: 'all',
          weather: weather,
        ),
      );
    } catch (e) {
      emit(HomeError('Failed to load data'));
    }
  }

  // Mock separate API call for weather
  Future<Map<String, dynamic>> _fetchWeatherData() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate network delay
    return {
      'temperature': '24°C',
      'condition': 'Sunny',
      'icon': 'sunny', // Simple string identifier for now
    };
  }

  // Mock separate API call for future weather
  Future<Map<String, dynamic>> fetchFutureWeather(DateTime date) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Mock data based on date (simple randomization or static)
    return {
      'date': '${date.day}/${date.month}',
      'temperature': '22°C',
      'condition': 'Cloudy',
      'humidity': '65%',
      'wind': '12 km/h',
      'icon': 'cloud',
      'description': 'Clouds and sun',
    };
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
        ),
      );
    }
  }

  void selectCategory(String categoryId) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      // Mock Filtering Logic
      // In a real app, we might fetch new data or filter a full list.
      // Here we will just reuse the mock data definition (duplicated for simplicity or defined as a static list in class).
      // For this step I will re-define the full list to filter from.

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
        ),
      );
    }
  }
}
