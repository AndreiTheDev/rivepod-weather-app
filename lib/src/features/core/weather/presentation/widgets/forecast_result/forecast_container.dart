import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/forecast_scroll_controller.dart';
import '../../../domain/models/weather.dart';
import '../weather_result/result_container.dart';

class ForecastContainer extends StatefulWidget {
  const ForecastContainer({required this.weatherList, super.key});

  final List<WeatherModel> weatherList;

  @override
  State<ForecastContainer> createState() => _ForecastContainerState();
}

class _ForecastContainerState extends State<ForecastContainer> {
  late final ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Consumer(
      builder: (
        final BuildContext context,
        final WidgetRef ref,
        final Widget? child,
      ) {
        final ForecastScrollContainer forecastController = ref.watch(
          forecastScrollControllerProvider(
            controller,
            MediaQuery.of(context).size.width - 56.0,
            widget.weatherList.length - 1,
          ),
        );
        return Expanded(
          child: GestureDetector(
            onHorizontalDragEnd: (final DragEndDetails details) async =>
                forecastController.onScreenDrag(details),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              itemExtent: MediaQuery.sizeOf(context).width - 56,
              scrollDirection: Axis.horizontal,
              children: [
                for (final WeatherModel weather in widget.weatherList)
                  ResultContainer(weather: weather),
              ],
            ),
          ),
        );
      },
    );
  }
}
