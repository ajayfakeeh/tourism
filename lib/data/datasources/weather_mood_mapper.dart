import 'package:location/domain/entities/weather.dart';

class WeatherMoodMapper {
  static List<String> getTagsForWeather(Weather weather) {
    final condition = weather.condition.toLowerCase();

    if (condition.contains('rain')) {
      return ['cozy', 'indoor', 'hot_beverage', 'tea', 'spicy'];
    } else if (condition.contains('clear') || condition.contains('sunny')) {
      return ['outdoor', 'rooftop', 'ice_cream', 'cold_beverage', 'view'];
    } else if (condition.contains('cloud')) {
      return ['walk', 'coffee', 'outdoor'];
    } else {
      return ['indoor']; // Default
    }
  }
}
