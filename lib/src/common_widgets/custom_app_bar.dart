import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../features/core/error_handling/logger.dart';
import '../utils/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.hasBackButton,
    required this.hasNotificationButton,
    super.key,
  });

  final bool hasBackButton;
  final bool hasNotificationButton;

  @override
  Widget build(final BuildContext context) {
    final Logger logger = getLogger(CustomAppBar);
    final bool isIos = Theme.of(context).platform == TargetPlatform.iOS;

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
                color: detailColor,
              ),
            const SizedBox(
              width: 1,
            ),
            if (hasNotificationButton)
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
                color: detailColor,
              ),
          ],
        ),
      ],
    );
  }
}
