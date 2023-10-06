import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database_repository.dart';

final friendsServiceProvider = Provider(
  (final ref) => FriendsService(
    ref.watch(databaseRepositoryProvider),
  ),
);

class FriendsService {
  FriendsService(this._databaseRepository);

  final DatabaseRepository _databaseRepository;

  Future<void> addFriend(final String uid) async {}

  // Future<void> checkIsFriend()async{}
  // Future<void> deleteFriend()async{}
  // Stream<void> getFriends(){}
}
