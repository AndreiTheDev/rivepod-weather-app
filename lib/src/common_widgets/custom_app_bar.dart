import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../features/core/error_handling/logger.dart';
import '../features/core/friends/domain/friends_controller.dart';
import '../utils/colors.dart' as colors;

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({
    required this.hasBackButton,
    required this.hasNotificationButton,
    super.key,
  });

  final bool hasBackButton;
  final bool hasNotificationButton;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final Logger logger = getLogger(CustomAppBar);
    final bool isIos = Theme.of(context).platform == TargetPlatform.iOS;
    final friendRequestsStream = ref.watch(friendsRequestListProvider);
    final bool hasNotification =
        friendRequestsStream.hasValue && friendRequestsStream.value!.isNotEmpty;

    return Column(
      children: <Widget>[
        const SizedBox(
          height: 26,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (hasBackButton)
              IconButton(
                onPressed: () {
                  logger.d('pop screen');
                  context.pop();
                },
                icon: isIos
                    ? const Icon(Icons.arrow_back_ios_new)
                    : const Icon(Icons.arrow_back),
                color: colors.detailColor,
              ),
            const SizedBox(
              width: 1,
            ),
            if (hasNotificationButton)
              IconButton(
                onPressed: () async => context.push('/friend-requests'),
                iconSize: 28,
                icon: Badge(
                  label: hasNotification
                      ? Text(friendRequestsStream.value!.length.toString())
                      : null,
                  isLabelVisible: hasNotification,
                  child: const Icon(
                    Icons.notifications,
                    color: colors.detailColor,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
