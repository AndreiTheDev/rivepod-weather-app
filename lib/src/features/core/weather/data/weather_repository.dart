// ignore_for_file: always_specify_types

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/api_keys.dart';
import '../../error_handling/logger.dart';
import 'weather_entity.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>(
  (final ref) => WeatherRepository(),
);

class WeatherRepository {
  final Dio _dio = Dio();
  final _logger = getLogger(WeatherRepository);

  Future<WeatherEntity> fetchCurrentWeather(final String city) async {
    _logger.d('fetchCurrentWeather - call');
    final Response<Map<String, dynamic>> response = await _dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: <String, dynamic>{
        'q': city,
        'units': 'metric',
        'appid': openWeatherKey,
      },
    );
    return WeatherEntity.fromData(response.data!);
  }

  Future<List<WeatherEntity>> fetch5DaysForecast(final String city) async {
    _logger.d('fetch5DaysForecast - call');
    final Response<Map<String, dynamic>> response = await _dio.get(
      'https://api.openweathermap.org/data/2.5/forecast',
      queryParameters: <String, dynamic>{
        'q': city,
        'units': 'metric',
        'appid': openWeatherKey,
      },
    );

    if (response.data == null) {
      throw Exception('null data');
    }

    final List<WeatherEntity> weatherEntities = [];
    final List<dynamic> responseList = response.data!['list'];

    for (final Map<String, dynamic> obj in responseList) {
      final String date = obj['dt_txt'];
      obj['name'] = city.replaceRange(0, 1, city[0].toUpperCase());
      if (date.endsWith('15:00:00')) {
        weatherEntities.add(WeatherEntity.fromData(obj));
      }
    }

    return weatherEntities;
  }
}
