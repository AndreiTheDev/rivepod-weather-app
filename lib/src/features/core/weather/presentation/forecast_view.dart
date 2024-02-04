import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/custom_app_bar.dart';
import '../../error_handling/logger.dart';
import '../domain/models/weather.dart';
import '../domain/weather_controller.dart';
import 'widgets/forecast_result/forecast_container.dart';
import 'widgets/weather_result/result_container_loading.dart';

class ForecastView extends StatelessWidget {
  const ForecastView({super.key});

  @override
  Widget build(final BuildContext context) {
    getLogger(ForecastView).d('build');

    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: CustomAppBar(
            hasBackButton: true,
            hasNotificationButton: true,
          ),
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
            final AsyncValue<List<WeatherModel>?> weatherList = ref.watch(
              weatherControllerProvider
                  .select((final WeatherState value) => value.forecast),
            );

            return weatherList.when(
              data: (final List<WeatherModel>? data) {
                if (data != null) {
                  return ForecastContainer(weatherList: data);
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
    );
  }
}
