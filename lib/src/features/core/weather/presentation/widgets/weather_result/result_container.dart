// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../settings/domain/user_prefs_controller.dart';
import '../../../domain/models/weather.dart';
import 'result_card.dart';

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
            '${weather.dateTime.day} Jan ${weather.dateTime.year}',
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
                ResultRow(
                  title: AppLocalizations.of(context)!.humidity,
                  data: '${weather.humidity}%',
                ),
                const SizedBox(
                  height: 24,
                ),
                ResultRow(
                  title: AppLocalizations.of(context)!.uvIndex,
                  data: '4',
                ),
                const SizedBox(
                  height: 24,
                ),
                Consumer(
                  builder: (final context, final ref, final child) => ResultRow(
                    title: AppLocalizations.of(context)!.windSpeed,
                    data: ref.read(
                      userPrefsControllerProvider
                          .select((final state) => state.metricUnits),
                    )
                        ? '${weather.windSpeed} km/h'
                        : '${weather.windSpeed} mi/h',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ResultRow(
                  title: AppLocalizations.of(context)!.rainProbability,
                  data: '${weather.humidity}%',
                ),
                const SizedBox(
                  height: 24,
                ),
                ResultRow(
                  title: AppLocalizations.of(context)!.pressure,
                  data: '${weather.pressure} Pa',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResultRow extends StatelessWidget {
  const ResultRow({required this.title, required this.data, super.key});

  final String title;
  final String data;

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Text>[
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          data,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
