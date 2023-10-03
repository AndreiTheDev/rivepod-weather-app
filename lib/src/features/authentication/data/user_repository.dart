import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/error_handling/app_exceptions/app_exception.dart';
import '../../core/error_handling/app_exceptions/error_types.dart';
import 'entities/user_entity.dart';

final userRepositoryProvider =
    Provider<UserRepository>((final ref) => UserRepository());

class UserRepository {
  final _firesotreInstance = FirebaseFirestore.instance;

  Future<UserEntity> getUser(final User user) async {
    final userDoc =
        await _firesotreInstance.collection('/users').doc(user.uid).get();
    if (!userDoc.exists) {
      throw AppException.getFirebaseException(
        userNotExistsCode,
      );
    }
    if (userDoc.data() != null) {
      return UserEntity.fromData(user, userDoc.data()!);
    }
    throw AppException.getFirebaseException(
      noUserDataCode,
    );
  }

  Future<void> postUser(final String uid, final UserEntity entity) async {
    await _firesotreInstance
        .collection('/users')
        .doc(uid)
        .set(entity.toDatabase());
  }

  Future<bool> isUserInDatabase(final String username) async {
    final userDoc = await _firesotreInstance
        .collection('/users')
        .where('username', isEqualTo: username.toLowerCase())
        .get();

    if (userDoc.docs.isEmpty) {
      return false;
    }
    return true;
  }
}
