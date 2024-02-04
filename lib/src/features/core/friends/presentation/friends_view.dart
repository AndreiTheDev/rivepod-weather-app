import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../utils/box_decoration.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../../utils/dialogs.dart';
import '../../error_handling/logger.dart';
import '../../error_handling/snackbar_controller.dart';
import '../../friends/domain/friends_controller.dart';
import '../domain/models/friend.dart';

class FriendsView extends ConsumerWidget {
  const FriendsView({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    getLogger(FriendsView).d('build');
    snackbarDisplayer(context, ref);

    final liveFriends = ref.watch(friendsListProvider);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child:
              CustomAppBar(hasBackButton: false, hasNotificationButton: true),
        ),
        liveFriends.when(
          data: (final friends) {
            return Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (final context, final index) {
                  return ListItem(
                    friendModel: friends[index],
                  );
                },
                separatorBuilder: (final context, final index) =>
                    const SizedBox(
                  height: 20,
                ),
                itemCount: friends.length,
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
    required this.friendModel,
    super.key,
  });

  final Friend friendModel;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 70,
      decoration: boxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              const Icon(
                Icons.person,
                color: colors.detailColor,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                friendModel.username,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          Consumer(
            builder: (final context, final ref, final child) => IconButton(
              onPressed: () async {
                await showConfirmationDialog(
                  context,
                  'Are you sure you want to delete ${friendModel.username}?',
                  friendModel,
                );
              },
              icon: child!,
            ),
            child: const Icon(
              Icons.close,
              color: colors.detailColor,
            ),
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
        height: 70,
      ),
    );
  }
}
