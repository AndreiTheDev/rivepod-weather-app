import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/entities/weather_entity.dart';

part 'weather.freezed.dart';

@freezed
class WeatherModel with _$WeatherModel {
  factory WeatherModel({
    required final String city,
    required final String temp,
    required final String feelsLike,
    required final String pressure,
    required final String humidity,
    required final String windSpeed,
    required final DateTime dateTime,
    required final String description,
    required final int iconId,
    required final bool isMetricUnits,
  }) = _WeatherModel;

  WeatherModel._();

  factory WeatherModel.fromEntity(final WeatherEntity entity) {
    return WeatherModel(
      city: entity.city,
      temp: entity.temp,
      feelsLike: entity.feelsLike,
      pressure: entity.pressure,
      humidity: entity.humidity,
      windSpeed: entity.windSpeed,
      dateTime: entity.dateTime,
      description: entity.description,
      iconId: entity.iconId,
      isMetricUnits: entity.isMetricUnits,
    );
  }

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
      isMetricUnits: isMetricUnits,
    );
  }
}
