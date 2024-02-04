import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/entities/friend_entity.dart';

part 'friend.freezed.dart';

@freezed
class Friend with _$Friend {
  factory Friend({
    required final String email,
    required final String uid,
    required final String username,
  }) = _Friend;

  Friend._();

  factory Friend.fromEntity(final FriendEntity entity) {
    return Friend(
      email: entity.email,
      uid: entity.uid,
      username: entity.username,
    );
  }

  FriendEntity toEntity() {
    return FriendEntity(email: email, uid: uid, username: username);
  }
}
