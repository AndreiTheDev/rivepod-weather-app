import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/forecast_scroll_controller.dart';
import '../../../domain/models/weather.dart';
import '../weather_result/result_container.dart';

class ForecastContainer extends StatefulWidget {
  const ForecastContainer({required this.weatherList, super.key});

  final List<Weather> weatherList;

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
  Widget build(final BuildContext context) {
    return Consumer(
      builder: (
        final BuildContext context,
        final WidgetRef ref,
        final Widget? child,
      ) {
        final ForecastScrollContainer forecastController = ref.watch(
          forecastScrollController(
            <String, dynamic>{
              'scrollController': controller,
              'offset': MediaQuery.of(context).size.width - 56.0,
              'listLength': widget.weatherList.length - 1,
            },
          ),
        );
        return GestureDetector(
          onHorizontalDragEnd: (final DragEndDetails details) async =>
              forecastController.onScreenDrag(details),
          child: SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: Row(
              children: <ResultContainer>[
                for (final Weather weather in widget.weatherList)
                  ResultContainer(weather: weather),
              ],
            ),
          ),
        );
      },
    );
  }
}
