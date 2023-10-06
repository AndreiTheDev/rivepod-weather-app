import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/domain/auth_controller.dart';

final friendsRepositoryProvider = Provider(
  (final ref) => FriendsRepository(
    ref.watch(authStateProvider),
  ),
);

class FriendsRepository {
  FriendsRepository(this.authState);

  final AuthState authState;
  final FirebaseFirestore _dbInstance = FirebaseFirestore.instance;

  Future<void> addFriend(final String uid) async {
    _dbInstance
        .collection('users')
        .doc(authState.user!.uid)
        .collection('friends')
        .doc(uid)
        .set({});
  }
}
