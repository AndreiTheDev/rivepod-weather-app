import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../utils/box_decoration.dart';
import '../../../../utility_providers/weather_icon_provider.dart';
import '../../../domain/models/weather.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({required this.weather, super.key});

  final WeatherModel weather;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      child: Container(
        height: 180,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        decoration: boxDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${weather.temp}°',
                  style: const TextStyle(
                    fontSize: 90,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -2,
                    height: 0,
                    shadows: <Shadow>[
                      Shadow(color: Color(0xFFD0D0D0), offset: Offset(3, 3)),
                    ],
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.realFeel(weather.feelsLike),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Consumer(
                  builder: (final context, final ref, final child) =>
                      SvgPicture.asset(
                    ref.read(weatherIconProvider(weather.iconId)),
                    height: 120,
                  ),
                ),
                Text(
                  weather.description,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
