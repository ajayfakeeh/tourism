import 'package:location/domain/entities/weather.dart';

class MockWeatherService {
  Future<Weather> getCurrentWeather() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Hardcoded response as per requirements
    // JSON structure: {"temp": 24, "condition": "Rainy", "description": "Light Rain"}
    return const Weather(
      temperature: 24.0,
      condition: 'Rainy',
      description: 'Light Rain',
    );
  }
}
