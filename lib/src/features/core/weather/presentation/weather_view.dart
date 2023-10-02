import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/custom_app_bar.dart';
import '../../error_handling/logger.dart';
import '../domain/models/weather.dart';
import '../domain/weather_controller.dart';
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
              final AsyncValue<WeatherModel?> weather = ref.watch(
                weatherControllerProvider
                    .select((final WeatherState value) => value.weather),
              );

              return weather.when(
                data: (final WeatherModel? data) {
                  if (data != null) {
                    return ResultContainer(weather: data);
                  }
                  return const Text('Search a city name');
                },
                loading: ResultContainerLoading.new,
                error: (final Object error, final StackTrace stackTrace) =>
                    Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    const Text(
                      'Wrong city name.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
