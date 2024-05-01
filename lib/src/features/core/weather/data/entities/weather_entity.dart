// ignore_for_file: avoid_dynamic_calls, avoid_positional_boolean_parameters

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_entity.freezed.dart';

@freezed
class WeatherEntity with _$WeatherEntity {
  factory WeatherEntity({
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
  }) = _WeatherEntity;

  WeatherEntity._();

  factory WeatherEntity.fromData(
    final Map<String, dynamic> data,
    final bool metricUnits,
  ) {
    final num temp = data['main']['temp'];
    final num feelsLike = data['main']['feels_like'];
    final num pressure = data['main']['pressure'];
    final num humidity = data['main']['humidity'];
    final num windSpeed = data['wind']['speed'];
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000);

    return WeatherEntity(
      city: data['name'],
      temp: temp.toStringAsFixed(0),
      feelsLike: feelsLike.toStringAsFixed(0),
      pressure: pressure.toStringAsFixed(0),
      humidity: humidity.toStringAsFixed(0),
      windSpeed: windSpeed.toStringAsFixed(1),
      dateTime: dateTime,
      description: data['weather'][0]['description'],
      iconId: data['weather'][0]['id'] as int,
      isMetricUnits: metricUnits,
    );
  }

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'city': city,
      'temp': temp,
      'feelsLike': feelsLike,
      'pressure': pressure,
      'humidity': humidity,
      'windSpeed': windSpeed,
      'description': description,
      'iconId': iconId,
      'isMetricUnits': isMetricUnits,
    };
  }
}
