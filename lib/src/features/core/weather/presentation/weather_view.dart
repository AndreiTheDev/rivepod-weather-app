import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/custom_app_bar.dart';
import '../../error_handling/logger.dart';
import '../domain/current_weather_controller.dart';
import '../domain/models/weather.dart';
// import 'widgets/result_card.dart';
import 'widgets/weather_result/result_container.dart';
import 'widgets/weather_result/result_container_loading.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(final BuildContext context) {
    getLogger(WeatherView).d('build');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          const CustomAppBar(
            hasBackButton: true,
            hasNotificationButton: true,
          ),
          const SizedBox(
            height: 20,
          ),
          Consumer(
            builder: (
              final BuildContext context,
              final WidgetRef ref,
              final Widget? child,
            ) {
              final AsyncValue<Weather?> weather = ref.watch(
                weatherControllerProvider
                    .select((final WeatherState value) => value.weather),
              );

              return weather.when(
                data: (final Weather? data) {
                  if (data != null) {
                    return ResultContainer(weather: data);
                  }
                  return const Text('Search a city name');
                },
                loading: ResultContainerLoading.new,
                error: (final Object error, final StackTrace stackTrace) =>
                    const Text('error'),
              );
            },
          ),
        ],
      ),
    );
  }
}
