import '../../data/weather_entity.dart';

class Weather {
  Weather({
    required this.city,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.dateTime,
    required this.description,
    required this.iconId,
  });

  factory Weather.fromEntity(final WeatherEntity entity) {
    return Weather(
      city: entity.city,
      temp: entity.temp,
      feelsLike: entity.feelsLike,
      pressure: entity.pressure,
      humidity: entity.humidity,
      windSpeed: entity.windSpeed,
      dateTime: entity.dateTime,
      description: entity.description,
      iconId: entity.iconId,
    );
  }

  final String city;
  final String temp;
  final String feelsLike;
  final String pressure;
  final String humidity;
  final String windSpeed;
  final DateTime dateTime;
  final String description;
  final int iconId;

  WeatherEntity toEntity() {
    return WeatherEntity(
      city: city,
      temp: temp,
      feelsLike: feelsLike,
      pressure: pressure,
      humidity: humidity,
      windSpeed: windSpeed,
      dateTime: dateTime,
      description: description,
      iconId: iconId,
    );
  }
}
