// ignore_for_file: always_specify_types

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../error_handling/logger.dart';
import '../../error_handling/snackbar_controller.dart';
import '../services/weather_service.dart';
import 'models/weather.dart';

class WeatherState {
  WeatherState({required this.weather, required this.forecast});
  final _logger = getLogger(WeatherState);

  final AsyncValue<WeatherModel?> weather;
  final AsyncValue<List<WeatherModel>?> forecast;

  WeatherState copyWith({
    final AsyncValue<WeatherModel?>? weather,
    final AsyncValue<List<WeatherModel>?>? forecast,
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
    ref.watch(weatherServiceProvider),
    ref.read(snackbarControllerProvider.notifier),
  ),
);

class WeatherController extends StateNotifier<WeatherState> {
  WeatherController(this._service, this._snackbarController)
      : super(
          WeatherState(
            weather: const AsyncValue<WeatherModel?>.data(null),
            forecast: const AsyncValue<List<WeatherModel>?>.data(null),
          ),
        );

  final WeatherService _service;
  final SnackbarController _snackbarController;
  final Logger _logger = getLogger(WeatherController);

  Future<void> getCurrentWeather(final String city) async {
    _logger.d('getCurrentWeather - call');
    state = state.copyWith(weather: const AsyncValue<WeatherModel>.loading());

    final response = await _service.fetchCurrentWeather(city);

    response.when((final success) {
      final WeatherModel weatherModel = WeatherModel.fromEntity(success);

      state = state.copyWith(
        weather: AsyncValue<WeatherModel>.data(weatherModel),
      );
    }, (final error) {
      _snackbarController.setMessage(error.message, SnackbarType.error);
      state = state.copyWith(
        weather: AsyncValue.error(error.message, StackTrace.current),
      );
    });
  }

  Future<void> get5DaysForecast(final String city) async {
    _logger.d('get5DaysForecast - call');
    state = state.copyWith(
      forecast: const AsyncValue<List<WeatherModel>>.loading(),
    );

    final response = await _service.fetch5DaysForecast(city);

    response.when((final success) {
      final List<WeatherModel> weatherList =
          success.map(WeatherModel.fromEntity).toList();
      state = state.copyWith(
        forecast: AsyncValue<List<WeatherModel>>.data(weatherList),
      );
    }, (final error) {
      _snackbarController.setMessage(error.message, SnackbarType.error);
      state = state.copyWith(
        forecast: AsyncValue.error(error.message, StackTrace.current),
      );
    });
  }
}
