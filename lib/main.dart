import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'src/app.dart';
import 'src/features/authentication/domain/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } on Exception catch (e) {
      print(e);
    }
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final authContainer = ProviderContainer();
  await authContainer.read(authControllerProvider).initState();

  runApp(
    UncontrolledProviderScope(
      container: authContainer,
      child: const MyApp(),
    ),
  );
}
