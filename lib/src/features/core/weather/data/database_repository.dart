// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../authentication/domain/auth_controller.dart';
import '../../error_handling/app_exceptions/app_exception.dart';
import '../../error_handling/app_exceptions/error_types.dart';
import 'entities/weather_entity.dart';

part 'database_repository.g.dart';

@Riverpod(keepAlive: true)
DatabaseRepository databaseRepository(final DatabaseRepositoryRef ref) =>
    DatabaseRepository(
      ref.watch(authStateProvider),
    );

class DatabaseRepository {
  DatabaseRepository(this.authState);

  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final AuthState authState;

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

  Stream<QuerySnapshot<Map<String, dynamic>>> getWeatherSearches() {
    return _instance
        .collection('searches')
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots();
  }
}
