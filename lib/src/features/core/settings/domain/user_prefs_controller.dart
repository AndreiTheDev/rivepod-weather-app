// ignore_for_file: avoid_positional_boolean_parameters

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/user_prefs_repository.dart';

part 'user_prefs_controller.g.dart';

class UserPrefsState {
  UserPrefsState({
    required this.metricUnits,
    required this.incognitoMode,
    required this.notifications,
  });

  final bool metricUnits;
  final bool incognitoMode;
  final bool notifications;

  UserPrefsState copyWith({
    final bool? metricUnits,
    final bool? incognitoMode,
    final bool? notifications,
  }) {
    return UserPrefsState(
      metricUnits: metricUnits ?? this.metricUnits,
      incognitoMode: incognitoMode ?? this.incognitoMode,
      notifications: notifications ?? this.notifications,
    );
  }
}

@Riverpod(keepAlive: true)
class UserPrefsController extends _$UserPrefsController {
  @override
  UserPrefsState build() {
    _prefsRepository = ref.watch(userPrefsRepositoryProvider);
    return UserPrefsState(
      metricUnits: _prefsRepository.getMetricUnits(),
      incognitoMode: _prefsRepository.getIncognitoMode(),
      notifications: _prefsRepository.getNotifications(),
    );
  }

  late final UserPrefsRepository _prefsRepository;

  Future<void> setMetricUnits(final bool value) async {
    state = state.copyWith(metricUnits: value);
    await _prefsRepository.setMetricUnits(value);
  }

  Future<void> setIncognitoMode(final bool value) async {
    state = state.copyWith(incognitoMode: value);
    await _prefsRepository.setIncognitoMode(value);
  }

  Future<void> setNotifications(final bool value) async {
    state = state.copyWith(notifications: value);
    await _prefsRepository.setNotifications(value);
  }
}
