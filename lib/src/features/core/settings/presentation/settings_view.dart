import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common_widgets/custom_app_bar.dart';
import '../../../../utils/box_decoration.dart';
import '../../../../utils/colors.dart';
import '../../../authentication/domain/auth_controller.dart';
import '../../error_handling/logger.dart';
import '../domain/user_prefs_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool metricSwitchValue = true;
  bool incognitoSwitchValue = false;
  bool notificationsSwitchValue = true;

  @override
  Widget build(final BuildContext context) {
    getLogger(SettingsView).d('build');

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(hasBackButton: false, hasNotificationButton: true),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            height: 152,
            decoration: boxDecoration,
            child: Row(
              children: [
                const PhotoPlaceholder(),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Consumer(
                    builder: (final context, final ref, final child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ref
                                .read(authControllerProvider)
                                .authState
                                .user!
                                .username,
                            textScaler: const TextScaler.linear(1.4),
                          ),
                          Text(
                            ref
                                .read(authControllerProvider)
                                .authState
                                .user!
                                .email,
                          ),
                          ConstrainedBox(
                            constraints:
                                const BoxConstraints(minWidth: double.infinity),
                            child: ElevatedButton(
                              onPressed: () async {
                                await ref
                                    .read(authControllerProvider)
                                    .signOutUser();
                              },
                              child: child,
                            ),
                          ),
                        ],
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.signOut),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          Text(
            AppLocalizations.of(context)!.settings.toUpperCase(),
            textScaler: const TextScaler.linear(1.4),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 16,
          ),
          Consumer(
            builder: (final context, final ref, final child) {
              return SettingsRow(
                text: AppLocalizations.of(context)!.metricUnits,
                value: ref.watch(
                  userPrefsControllerProvider
                      .select((final state) => state.metricUnits),
                ),
                onChanged: (final bool value) async {
                  await ref
                      .read(userPrefsControllerProvider.notifier)
                      .setMetricUnits(value);
                },
              );
            },
          ),
          Consumer(
            builder: (final context, final ref, final child) {
              return SettingsRow(
                text: AppLocalizations.of(context)!.incognitoMode,
                value: ref.watch(
                  userPrefsControllerProvider
                      .select((final state) => state.incognitoMode),
                ),
                onChanged: (final bool value) async {
                  await ref
                      .read(userPrefsControllerProvider.notifier)
                      .setIncognitoMode(value);
                },
              );
            },
          ),
          Consumer(
            builder: (final context, final ref, final child) {
              return SettingsRow(
                text: AppLocalizations.of(context)!.notifications,
                value: ref.watch(
                  userPrefsControllerProvider
                      .select((final state) => state.notifications),
                ),
                onChanged: (final bool value) async {
                  await ref
                      .read(userPrefsControllerProvider.notifier)
                      .setNotifications(value);
                },
              );
            },
          ),
          const SizedBox(
            height: 36,
          ),
          Text(
            AppLocalizations.of(context)!.about,
            textScaler: const TextScaler.linear(1.4),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            AppLocalizations.of(context)!.version('1.2.5'),
            textScaler: const TextScaler.linear(1.1),
          ),
          Text(
            AppLocalizations.of(context)!.authors('Emanuel Lamba'),
            textScaler: const TextScaler.linear(1.1),
          ),
          RichText(
            textScaler: const TextScaler.linear(1.1),
            text: TextSpan(
              text: 'Design: ',
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: 'Behance',
                  style: const TextStyle(color: detailColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final uri = Uri.parse(
                        'https://www.behance.net/gallery/90366995/Weather-App?tracking_source=search_projects_appreciations%7Cweather+app',
                      );
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      }
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: avoid_positional_boolean_parameters
typedef OnSwitchChanged = void Function(bool value);

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    required this.text,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String text;
  final bool value;
  final OnSwitchChanged onChanged;

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          textScaler: const TextScaler.linear(1.2),
        ),
        Transform.scale(
          scale: 0.8,
          child: Switch.adaptive(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class PhotoPlaceholder extends StatefulWidget {
  const PhotoPlaceholder({
    super.key,
  });

  @override
  State<PhotoPlaceholder> createState() => _PhotoPlaceholderState();
}

class _PhotoPlaceholderState extends State<PhotoPlaceholder> {
  double opacity = 1;
  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async => _playAnimation(),
        child: AnimatedOpacity(
          opacity: opacity,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 150),
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
      ),
    );
  }

  Future<void> _playAnimation() async {
    setState(() {
      opacity = 0.5;
    });
    await Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        opacity = 1;
      });
    });
  }
}
