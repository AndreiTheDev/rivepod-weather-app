// ignore_for_file: always_specify_types, avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../utils/api_keys.dart';
import '../../error_handling/logger.dart';
import 'entities/weather_entity.dart';

part 'weather_repository.g.dart';

@Riverpod(keepAlive: true)
WeatherRepository weatherRepository(final WeatherRepositoryRef ref) =>
    WeatherRepository();

class WeatherRepository {
  final Dio _dio = Dio();
  final _logger = getLogger(WeatherRepository);

  Future<WeatherEntity> fetchCurrentWeather(
    final String city,
    final String units,
  ) async {
    _logger.d('fetchCurrentWeather - call');
    final Response<Map<String, dynamic>> response = await _dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: <String, dynamic>{
        'q': city,
        'units': units,
        'appid': openWeatherKey,
      },
    );
    if (response.data == null) {
      throw Exception('null data');
    }

    if (units == 'metric') {
      response.data!['wind']['speed'] = response.data!['wind']['speed'] * 3.6;
      return WeatherEntity.fromData(response.data!, true);
    } else {
      return WeatherEntity.fromData(response.data!, false);
    }
  }

  Future<List<WeatherEntity>> fetch5DaysForecast(
    final String city,
    final String units,
  ) async {
    _logger.d('fetch5DaysForecast - call');
    final Response<Map<String, dynamic>> response = await _dio.get(
      'https://api.openweathermap.org/data/2.5/forecast',
      queryParameters: <String, dynamic>{
        'q': city,
        'units': units,
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
      if (date.endsWith('15:00:00') && units == 'metric') {
        obj['wind']['speed'] = obj['wind']['speed'] * 3.6;
        weatherEntities.add(WeatherEntity.fromData(obj, true));
      }
      if (date.endsWith('15:00:00') && units == 'imperial') {
        weatherEntities.add(WeatherEntity.fromData(obj, false));
      }
    }

    return weatherEntities;
  }
}
