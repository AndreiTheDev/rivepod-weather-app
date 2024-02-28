import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'src/app.dart';
import 'src/features/authentication/domain/auth_controller.dart';
import 'src/features/core/notifications/domain/notifications_controller.dart';
import 'src/features/core/settings/data/user_prefs_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate();

  if (kDebugMode) {
    try {
      const ip = '192.168.100.48';
      FirebaseFirestore.instance.useFirestoreEmulator(ip, 8080);
      FirebaseFunctions.instance.useFunctionsEmulator(ip, 5001);
      await FirebaseStorage.instance.useStorageEmulator(ip, 9199);
      await FirebaseAuth.instance.useAuthEmulator(ip, 9099);
    } on Exception catch (e) {
      print(e);
    }
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final initContainer = ProviderContainer();
  await initContainer.read(authControllerProvider).initState();
  await initContainer.read(userPrefsRepositoryProvider).initRepository();
  await initContainer.read(notificationsControllerProvider).init();

  runApp(
    UncontrolledProviderScope(
      container: initContainer,
      child: const MyApp(),
    ),
  );
}
