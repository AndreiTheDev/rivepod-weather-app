// ignore_for_file: avoid_dynamic_calls
class WeatherEntity {
  WeatherEntity({
    required this.city,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.dateTime,
    required this.description,
    required this.iconId,
  });

  final String city;
  final String temp;
  final String feelsLike;
  final String pressure;
  final String humidity;
  final String windSpeed;
  final DateTime dateTime;
  final String description;
  final int iconId;

  factory WeatherEntity.fromData(final Map<String, dynamic> data) {
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
    );
  }
}
