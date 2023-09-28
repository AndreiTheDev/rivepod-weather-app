import 'package:flutter/material.dart';

import '../../error_handling/logger.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  @override
  Widget build(final BuildContext context) {
    getLogger(FriendsView).d('build');
    return const Center(
      child: Text('friends'),
    );
  }
}
