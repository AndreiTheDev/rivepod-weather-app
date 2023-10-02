import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherIconProvider =
    Provider.autoDispose.family<String, int>((final ref, final int family) {
  if (family == 211) {
    return 'assets/weather_icons/Weather_Icons-Thunder.svg';
  }
  if (family >= 200 && family < 300) {
    return 'assets/weather_icons/Weather_Icons-Thunderstorm.svg';
  }
  if (family >= 300 && family < 400) {
    return 'assets/weather_icons/Weather_Icons-Drizzle.svg';
  }
  // if ((family == 500 || family == 501) && (time.hour > 18 || time.hour < 9)) {
  //   return 'assets/weather_icons/Weather_Icons-Rainy-Moon.svg';
  // }
  if (family == 500 || family == 501) {
    return 'assets/weather_icons/Weather_Icons-Rainy-Sun.svg';
  }
  if (family >= 502 && family < 600) {
    return 'assets/weather_icons/Weather_Icons-Rainy-Strong.svg';
  }
  if (family >= 600 && family < 700) {
    return 'assets/weather_icons/Weather_Icons-Snow.svg';
  }
  if (family >= 700 && family < 800) {
    return 'assets/weather_icons/Weather_Icons-Mist.svg';
  }
  // if (family == 800 && (time.hour > 18 || time.hour < 9)) {
  //   return 'assets/weather_icons/Weather_Icons-Moon.svg';
  // }
  if (family == 800) {
    return 'assets/weather_icons/Weather_Icons-Sun.svg';
  }
  // if ((family == 801 || family == 802) && (time.hour > 18 || time.hour < 9)) {
  //   return 'assets/weather_icons/Weather_Icons-Clouds-Moon.svg';
  // }
  if (family == 801 || family == 802) {
    return 'assets/weather_icons/Weather_Icons-Clouds-Sun.svg';
  }
  if (family == 803 || family == 804) {
    return 'assets/weather_icons/Weather_Icons-Broken-Clouds.svg';
  }
  return '';
});
