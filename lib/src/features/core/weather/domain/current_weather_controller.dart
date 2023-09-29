// ignore_for_file: always_specify_types

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../error_handling/logger.dart';
import '../../error_handling/snackbar_controller.dart';
import '../data/weather_entity.dart';
import '../data/weather_repository.dart';
import 'models/weather.dart';

class WeatherState {
  WeatherState({required this.weather, required this.forecast});
  final _logger = getLogger(WeatherState);

  final AsyncValue<Weather?> weather;
  final AsyncValue<List<Weather>?> forecast;

  WeatherState copyWith({
    final AsyncValue<Weather?>? weather,
    final AsyncValue<List<Weather>?>? forecast,
  }) {
    _logger.d('updating WeatherState');
    return WeatherState(
      weather: weather ?? this.weather,
      forecast: forecast ?? this.forecast,
    );
  }
}

final weatherControllerProvider =
    StateNotifierProvider<WeatherController, WeatherState>(
  (final ref) => WeatherController(
    ref.watch(weatherRepositoryProvider),
    ref.read(snackbarControllerProvider.notifier),
  ),
);

class WeatherController extends StateNotifier<WeatherState> {
  WeatherController(this._repository, this._snackbarController)
      : super(
          WeatherState(
            weather: const AsyncValue<Weather?>.data(null),
            forecast: const AsyncValue<List<Weather>?>.data(null),
          ),
        );

  final WeatherRepository _repository;
  final SnackbarController _snackbarController;
  final Logger _logger = getLogger(WeatherController);

  Future<void> getCurrentWeather(final String city) async {
    _logger.d('getCurrentWeather - call');
    state = state.copyWith(weather: const AsyncValue<Weather>.loading());

    final WeatherEntity response = await _repository.fetchCurrentWeather(city);

    final Weather weatherModel = Weather.fromEntity(response);

    state = state.copyWith(weather: AsyncValue<Weather>.data(weatherModel));
  }

  Future<void> get5DaysForecast(final String city) async {
    _logger.d('get5DaysForecast - call');
    state = state.copyWith(forecast: const AsyncValue<List<Weather>>.loading());

    final List<WeatherEntity> response =
        await _repository.fetch5DaysForecast(city);

    final List<Weather> weatherList = response.map(Weather.fromEntity).toList();

    state =
        state.copyWith(forecast: AsyncValue<List<Weather>>.data(weatherList));
  }
}
