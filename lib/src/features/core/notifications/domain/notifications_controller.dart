// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../authentication/domain/auth_controller.dart';
import '../../error_handling/logger.dart';

part 'notifications_controller.g.dart';

@Riverpod(keepAlive: true)
NotificationsController notificationsController(
  final NotificationsControllerRef ref,
) {
  final notificationController = NotificationsController(ref);
  ref.listen(authStateProvider, (final previous, final next) async {
    await notificationController.sendFcmToken(next);
  });
  return notificationController;
}

class NotificationsController {
  NotificationsController(this._ref);

  final _messagingInstance = FirebaseMessaging.instance;
  final _firestoreInstance = FirebaseFirestore.instance;
  final NotificationsControllerRef _ref;
  final Logger _logger = getLogger(NotificationsController);

  Future<void> init() async {
    final authState = _ref.read(authStateProvider);
    await sendFcmToken(authState);
  }

  Future<void> sendFcmToken(final AuthState auth) async {
    try {
      _logger.d('sendFcmToken - call');
      await _messagingInstance.requestPermission();

      final fcmToken = await _messagingInstance.getToken();

      if (auth.authUserState == AuthUserState.signedIn && auth.user != null) {
        await _firestoreInstance
            .collection('users')
            .doc(auth.user!.uid)
            .update({'fcmToken': fcmToken});
      }
    } on Exception {
      _logger.e('sendFcmToken - exception');
    }
  }
}
