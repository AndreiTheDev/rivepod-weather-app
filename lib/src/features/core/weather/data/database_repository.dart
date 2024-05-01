// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../authentication/domain/auth_controller.dart';
import '../../error_handling/app_exceptions/app_exception.dart';
import '../../error_handling/app_exceptions/error_types.dart';
import '../../settings/domain/user_prefs_controller.dart';
import 'entities/weather_entity.dart';

part 'database_repository.g.dart';

@Riverpod(keepAlive: true)
DatabaseRepository databaseRepository(final DatabaseRepositoryRef ref) =>
    DatabaseRepository(
      ref.watch(authStateProvider),
      isIncognito: ref.watch(
        userPrefsControllerProvider
            .select((final prefsState) => prefsState.incognitoMode),
      ),
    );

class DatabaseRepository {
  DatabaseRepository(this.authState, {required this.isIncognito});

  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final AuthState authState;
  final bool isIncognito;

  Future<void> postWeatherSearch(final WeatherEntity entity) async {
    final user = authState.user;

    if (user == null) {
      throw AppException(code: nullUserCode, message: nullUserMessage);
    }

    final WriteBatch batch = _instance.batch()
      ..set(_instance.collection('searches').doc(), <String, dynamic>{
        'weather': entity.toDatabase(),
        'user': user.toDatabase(),
        'timestamp': Timestamp.now(),
        'docId': const Uuid().v4(),
        'isIncognito': isIncognito,
      })
      ..set(
        _instance
            .collection('users')
            .doc(user.uid)
            .collection('user_searches')
            .doc(),
        {
          'weather': entity.toDatabase(),
          'timestamp': Timestamp.now(),
        },
      );
    await batch.commit();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchNextSearches(
    final DocumentSnapshot lastDoc,
  ) {
    return _instance
        .collection('searches')
        .orderBy('timestamp', descending: true)
        .limit(10)
        .startAfterDocument(lastDoc)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getWeatherSearches() {
    return _instance
        .collection('searches')
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots();
  }
}
