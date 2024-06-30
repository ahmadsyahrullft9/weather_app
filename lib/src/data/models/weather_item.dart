import 'package:equatable/equatable.dart';
import 'package:weather_app/src/data/models/city.dart';
import 'package:weather_app/src/data/models/forecast.dart';
import 'package:weather_app/src/data/models/weather.dart';

class WeatherItem extends Equatable {
  final City? city;
  final Weather? weather;
  final Forecast? forecast;

  const WeatherItem({this.city, this.weather, this.forecast});

  WeatherItem copyWith(
          {final City? city,
          final Weather? weather,
          final Forecast? forecast}) =>
      WeatherItem(
          city: city ?? this.city,
          weather: weather ?? this.weather,
          forecast: forecast ?? this.forecast);

  @override
  List<Object?> get props => [city, weather, forecast];
}
