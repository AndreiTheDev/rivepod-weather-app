import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/domain/auth_controller.dart';
import '../../error_handling/logger.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(final BuildContext context) {
    getLogger(SettingsView).d('build');

    return Center(
      child: Consumer(
        builder: (final context, final ref, final child) {
          return ElevatedButton(
            onPressed: () async {
              await ref.read(authControllerProvider).signOutUser();
            },
            child: child,
          );
        },
        child: const Text('Sign Out'),
      ),
    );
  }
}
