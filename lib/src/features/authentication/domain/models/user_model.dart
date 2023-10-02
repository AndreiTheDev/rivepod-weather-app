import 'package:firebase_auth/firebase_auth.dart';

import '../../data/entities/user_entity.dart';

class UserModel {
  UserModel({
    required this.user,
    required this.uid,
    required this.favCity,
    required this.email,
    required this.username,
  });

  final User user;
  final String uid;
  final String favCity;
  final String email;
  final String username;

  factory UserModel.fromEntity(final UserEntity entity) {
    return UserModel(
      user: entity.user,
      uid: entity.uid,
      favCity: entity.favCity,
      email: entity.email,
      username: entity.username,
    );
  }

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'username': username,
    };
  }
}
