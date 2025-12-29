abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Map<String, dynamic>> foodSpotsOnWay;
  final List<Map<String, dynamic>> forgotToSave;
  final List<Map<String, dynamic>> justBeforeArrive;
  final List<Map<String, dynamic>> nearDestination;
  final String currentLocation;
  final List<Map<String, dynamic>> categories;
  final String selectedCategoryId;
  final Map<String, dynamic>? weather;
  final List<Map<String, dynamic>> forecast;
  final bool isForecastLoading;
  final bool isForecastVisible;

  HomeLoaded({
    required this.foodSpotsOnWay,
    required this.forgotToSave,
    required this.justBeforeArrive,
    required this.nearDestination,
    this.currentLocation = 'Osaka Castle',
    required this.categories,
    required this.selectedCategoryId,
    this.weather,
    this.forecast = const [],
    this.isForecastLoading = false,
    this.isForecastVisible = false,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
