import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../utils/box_decoration.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../../utils/dialogs.dart';
import '../../error_handling/logger.dart';
import '../../error_handling/snackbar_controller.dart';
import '../../friends/domain/friends_controller.dart';
import '../../utility_providers/searches_converter.dart';
import '../../utility_providers/weather_icon_provider.dart';
import '../domain/models/search.dart';

class SearchesView extends ConsumerWidget {
  const SearchesView({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    snackbarDisplayer(context, ref);
    getLogger(SearchesView).d('build');

    final liveSearches = ref.watch(convertedSearchesProvider);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child:
              CustomAppBar(hasBackButton: false, hasNotificationButton: true),
        ),
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
          loading: () => Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (final context, final index) {
                return const ListItemLoading();
              },
              separatorBuilder: (final context, final index) => const SizedBox(
                height: 20,
              ),
              itemCount: 10,
            ),
          ),
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
      decoration: boxDecoration,
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
                  Consumer(
                    builder: (final context, final ref, final child) =>
                        GestureDetector(
                      onTap: () async {
                        final bool isFriend = await ref
                            .read(friendsControllerProvider)
                            .checkIsFriendOrHasRequest(searchModel.uid);
                        if (context.mounted) {
                          await showFriendDialog(
                            context,
                            searchModel,
                            isFriend: isFriend,
                          );
                        }
                      },
                      child: Text(
                        searchModel.username,
                        style: const TextStyle(
                          fontSize: 20,
                          color: colors.detailColor,
                        ),
                      ),
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
                    '${searchModel.temp}°${searchModel.isMetricUnits ? 'C' : 'F'}',
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

class ListItemLoading extends StatelessWidget {
  const ListItemLoading({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colors.loadingColor,
      highlightColor: colors.primaryColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: colors.loadingColor,
        ),
        height: 120,
      ),
    );
  }
}
