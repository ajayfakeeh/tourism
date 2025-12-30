import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double temperature;
  final String condition; // e.g., 'Rainy', 'Sunny', 'Cloudy'
  final String description; // e.g., 'Light Rain', 'Clear Sky'

  const Weather({
    required this.temperature,
    required this.condition,
    required this.description,
  });

  @override
  List<Object?> get props => [temperature, condition, description];
}
