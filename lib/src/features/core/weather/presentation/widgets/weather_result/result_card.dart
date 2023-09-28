import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../utils/colors.dart' as colors;
import '../../../domain/models/weather.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({required this.weather, super.key});

  final Weather weather;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
      child: Container(
        height: 180,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        decoration: BoxDecoration(
          color: colors.primaryColor900,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0xFFFFFFFF),
              blurRadius: 8,
              offset: Offset(-7, -7),
            ),
            BoxShadow(
              color: Color(0xFFDDDDDD),
              blurRadius: 13,
              offset: Offset(7, 7),
            ),
          ],
        ),
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
                      Shadow(color: Color(0xFFD0D0D0), offset: Offset(3, 3))
                    ],
                  ),
                ),
                Text(
                  'Real Feel: ${weather.feelsLike}°',
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
                SvgPicture.asset(
                  'assets/icons/Weather_Icons-Broken-Clouds.svg',
                  height: 120,
                ),
                Text(
                  weather.description,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
