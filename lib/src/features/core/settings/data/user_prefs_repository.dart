// ignore_for_file: avoid_positional_boolean_parameters

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_prefs_repository.g.dart';

@Riverpod(keepAlive: true)
UserPrefsRepository userPrefsRepository(final UserPrefsRepositoryRef ref) =>
    UserPrefsRepository();

class UserPrefsRepository {
  late final SharedPreferences _preferences;

  Future<void> initRepository() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setMetricUnits(final bool value) async {
    final prefs = _preferences;

    await prefs.setBool('metric', value);
  }

  Future<void> setIncognitoMode(final bool value) async {
    final prefs = _preferences;

    await prefs.setBool('incognito', value);
  }

  Future<void> setNotifications(final bool value) async {
    final prefs = _preferences;

    await prefs.setBool('notifications', value);
  }

  bool getMetricUnits() {
    final prefs = _preferences;

    return prefs.getBool('metric') ?? true;
  }

  bool getIncognitoMode() {
    final prefs = _preferences;

    return prefs.getBool('incognito') ?? false;
  }

  bool getNotifications() {
    final prefs = _preferences;

    return prefs.getBool('notifications') ?? false;
  }
}
