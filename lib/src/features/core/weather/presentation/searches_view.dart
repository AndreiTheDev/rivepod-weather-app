import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../utils/colors.dart' as colors;
import '../../error_handling/logger.dart';
import '../../utility_providers/weather_icon_provider.dart';
import '../domain/models/search.dart';
import '../domain/searches_controller.dart';

class SearchesView extends ConsumerWidget {
  const SearchesView({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    getLogger(SearchesView).d('build');

    final liveSearches = ref.watch(searchesProvider);

    return Column(
      children: [
        const CustomAppBar(hasBackButton: false, hasNotificationButton: true),
        liveSearches.when(
          data: (final searches) {
            return Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (final context, final index) {
                  return ListItem(
                    searchModel: searches[index],
                  );
                },
                separatorBuilder: (final context, final index) =>
                    const SizedBox(
                  height: 20,
                ),
                itemCount: searches.length,
              ),
            );
          },
          error: (final error, final stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    required this.searchModel,
    super.key,
  });

  final SearchModel searchModel;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colors.primaryColor900,
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
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: colors.detailColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    searchModel.city,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    color: colors.detailColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    searchModel.username,
                    style: const TextStyle(
                      fontSize: 20,
                      color: colors.detailColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer(
                builder: (final context, final ref, final child) =>
                    SvgPicture.asset(
                  ref.read(weatherIconProvider(searchModel.iconId)),
                  height: 59,
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.thermostat,
                    color: colors.detailColor,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    '${searchModel.temp}°C',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
