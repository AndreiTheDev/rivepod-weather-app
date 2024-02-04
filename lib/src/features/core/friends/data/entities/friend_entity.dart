import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_entity.freezed.dart';

@freezed
class FriendEntity with _$FriendEntity {
  factory FriendEntity({
    required final String email,
    required final String uid,
    required final String username,
  }) = _FriendEntity;

  FriendEntity._();

  factory FriendEntity.fromDatabase(final Map<String, dynamic> data) {
    return FriendEntity(
      email: data['email'],
      uid: data['uid'],
      username: data['username'],
    );
  }

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'email': email,
      'uid': uid,
      'username': username,
    };
  }
}
