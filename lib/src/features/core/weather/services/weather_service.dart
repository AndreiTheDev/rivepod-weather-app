// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../error_handling/app_exceptions/app_exception.dart';
import '../../error_handling/app_exceptions/error_types.dart';
import '../../error_handling/logger.dart';
import '../../settings/domain/user_prefs_controller.dart';
import '../data/database_repository.dart';
import '../data/entities/weather_entity.dart';
import '../data/weather_repository.dart';

part 'weather_service.g.dart';

@Riverpod(keepAlive: true)
WeatherService weatherService(final WeatherServiceRef ref) => WeatherService(
      ref.watch(weatherRepositoryProvider),
      ref.watch(databaseRepositoryProvider),
      ref.watch(
        userPrefsControllerProvider.select((final state) => state.metricUnits),
      ),
    );

class WeatherService {
  WeatherService(
    this._weatherRepository,
    this._databaseRepository,
    this.userPrefUnits,
  );

  final WeatherRepository _weatherRepository;
  final DatabaseRepository _databaseRepository;
  final bool userPrefUnits;
  final Logger _logger = getLogger(WeatherService);

  Future<Result<WeatherEntity, AppException>> fetchCurrentWeather(
    final String city,
  ) async {
    try {
      final String units = userPrefUnits ? 'metric' : 'imperial';
      final responseEntity =
          await _weatherRepository.fetchCurrentWeather(city, units);
      await _databaseRepository.postWeatherSearch(responseEntity);

      return Success(responseEntity);
    } on DioException catch (e) {
      _logger.e('fetchCurrentWeather - Dio Exception - ${e.type}');
      return Error(AppException.getDioException(e.type));
    } on FirebaseException catch (e) {
      _logger.e('fetchCurrentWeather - Firebase Exception - ${e.code}');
      return Error(AppException.getFirebaseException(e.code));
    } on Exception {
      _logger.e('fetchCurrentWeather - Unknown Exception');
      return Error(
        AppException(code: unknownErrorCode, message: unknownErrorMessage),
      );
    }
  }

  Future<Result<List<WeatherEntity>, AppException>> fetch5DaysForecast(
    final String city,
  ) async {
    try {
      final String units = userPrefUnits ? 'metric' : 'imperial';
      final responseEntities =
          await _weatherRepository.fetch5DaysForecast(city, units);

      return Success(responseEntities);
    } on SocketException {
      return Error(
        AppException(
          code: 'socket-exception',
          message: 'No internet connection.',
        ),
      );
    } on DioException catch (e) {
      _logger.e('fetch5DaysForecast - Dio Exception - ${e.type}');
      return Error(AppException.getDioException(e.type));
    } on Exception {
      _logger.e('fetch5DaysForecast - Unknown Exception');
      return Error(
        AppException(code: unknownErrorCode, message: unknownErrorMessage),
      );
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSearchesStream() {
    return _databaseRepository.getWeatherSearches();
  }
}
