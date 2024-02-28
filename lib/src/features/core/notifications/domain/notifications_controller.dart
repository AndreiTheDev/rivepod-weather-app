import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../authentication/domain/auth_controller.dart';

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

  Future<void> init() async {
    final authState = _ref.read(authStateProvider);
    await sendFcmToken(authState);
  }

  Future<void> sendFcmToken(final AuthState auth) async {
    try {
      await _messagingInstance.requestPermission();

      final fcmToken = await _messagingInstance.getToken();

      if (auth.authUserState == AuthUserState.signedIn && auth.user != null) {
        await _firestoreInstance
            .collection('users')
            .doc(auth.user!.uid)
            .update({'fcmToken': fcmToken});
      }
    } on Exception {
      print('notifications error');
    }
  }
}
