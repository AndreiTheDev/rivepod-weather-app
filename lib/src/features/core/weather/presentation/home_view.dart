import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../error_handling/logger.dart';
import '../../error_handling/snackbar_controller.dart';
import '../domain/current_weather_controller.dart';
import '../domain/models/weather.dart';
import 'widgets/suffix_icon.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late bool isForecast;
  late final TextEditingController controller;
  late final Logger _logger;

  @override
  void initState() {
    super.initState();
    isForecast = false;
    controller = TextEditingController();
    _logger = getLogger(HomeView);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    _logger.d('build');
    snackbarDisplayer(context, ref);

    ref
      ..listen(
          weatherControllerProvider
              .select((final WeatherState value) => value.weather), (
        final AsyncValue<Weather?>? previous,
        final AsyncValue<Weather?> next,
      ) async {
        if (next.isLoading) {
          await context.push('/weather');
        }
      })
      ..listen(
          weatherControllerProvider
              .select((final WeatherState value) => value.forecast), (
        final AsyncValue<List<Weather>?>? previous,
        final AsyncValue<List<Weather>?> next,
      ) async {
        if (next.isLoading) {
          await context.push('/forecast');
        }
      });

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter city...',
                suffixIcon: SuffixIcon(
                  isActive: isForecast,
                  onTap: () {
                    setState(() {
                      isForecast = !isForecast;
                    });
                  },
                ),
                suffixIconConstraints: const BoxConstraints(maxHeight: 50),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.length > 2) {
                  if (!isForecast) {
                    await ref
                        .read(weatherControllerProvider.notifier)
                        .getCurrentWeather(controller.text);
                  } else {
                    await ref
                        .read(weatherControllerProvider.notifier)
                        .get5DaysForecast(controller.text);
                  }
                  controller.clear();
                }
              },
              child: const Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
