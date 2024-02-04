import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../utils/colors.dart';
import '../../../authentication/domain/auth_controller.dart';
import '../../error_handling/logger.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with TickerProviderStateMixin {
  @override
  Widget build(final BuildContext context) {
    getLogger(SettingsView).d('build');

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          const CustomAppBar(hasBackButton: false, hasNotificationButton: true),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor900,
              borderRadius: BorderRadius.circular(16),
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
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xFFBBBBBB),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0xFFCCCCCC),
                          blurRadius: 13,
                          offset: Offset(7, 7),
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
