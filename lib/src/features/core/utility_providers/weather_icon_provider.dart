// ignore_for_file: lines_longer_than_80_chars

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_icon_provider.g.dart';

@riverpod
String weatherIcon(final WeatherIconRef ref, final int iconCode) {
  if (iconCode == 211) {
    return 'assets/weather_icons/Weather_Icons-Thunder.svg';
  }
  if (iconCode >= 200 && iconCode < 300) {
    return 'assets/weather_icons/Weather_Icons-Thunderstorm.svg';
  }
  if (iconCode >= 300 && iconCode < 400) {
    return 'assets/weather_icons/Weather_Icons-Drizzle.svg';
  }
  // if ((family == 500 || family == 501) && (time.hour > 18 || time.hour < 9)) {
  //   return 'assets/weather_icons/Weather_Icons-Rainy-Moon.svg';
  // }
  if (iconCode == 500 || iconCode == 501) {
    return 'assets/weather_icons/Weather_Icons-Rainy-Sun.svg';
  }
  if (iconCode >= 502 && iconCode < 600) {
    return 'assets/weather_icons/Weather_Icons-Rainy-Strong.svg';
  }
  if (iconCode >= 600 && iconCode < 700) {
    return 'assets/weather_icons/Weather_Icons-Snow.svg';
  }
  if (iconCode >= 700 && iconCode < 800) {
    return 'assets/weather_icons/Weather_Icons-Mist.svg';
  }
  // if (family == 800 && (time.hour > 18 || time.hour < 9)) {
  //   return 'assets/weather_icons/Weather_Icons-Moon.svg';
  // }
  if (iconCode == 800) {
    return 'assets/weather_icons/Weather_Icons-Sun.svg';
  }
  // if ((family == 801 || family == 802) && (time.hour > 18 || time.hour < 9)) {
  //   return 'assets/weather_icons/Weather_Icons-Clouds-Moon.svg';
  // }
  if (iconCode == 801 || iconCode == 802) {
    return 'assets/weather_icons/Weather_Icons-Clouds-Sun.svg';
  }
  if (iconCode == 803 || iconCode == 804) {
    return 'assets/weather_icons/Weather_Icons-Broken-Clouds.svg';
  }
  return '';
}
