// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/widgets.dart';

import '../../../domain/models/weather.dart';
import 'result_card.dart';
import 'result_row.dart';

class ResultContainer extends StatelessWidget {
  const ResultContainer({required this.weather, super.key});

  final WeatherModel weather;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 56,
      child: Column(
        children: <Widget>[
          Text(
            weather.city,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            '${weather.dateTime.day} ${weather.dateTime.month} ${weather.dateTime.year}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ResultCard(weather: weather),
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Column(
              children: <Widget>[
                ResultRow(title: 'Humidity', data: '${weather.humidity}%'),
                const SizedBox(
                  height: 24,
                ),
                const ResultRow(title: 'UV Index', data: '4'),
                const SizedBox(
                  height: 24,
                ),
                ResultRow(
                  title: 'Wind Speed',
                  data: '${weather.windSpeed} km/h',
                ),
                const SizedBox(
                  height: 24,
                ),
                ResultRow(
                  title: 'Rain Probability',
                  data: '${weather.humidity}%',
                ),
                const SizedBox(
                  height: 24,
                ),
                ResultRow(title: 'Pressure', data: '${weather.pressure} Pa'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
