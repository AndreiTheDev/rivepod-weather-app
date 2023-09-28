import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  UserEntity({
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

  factory UserEntity.fromData(
    final User user,
    final Map<String, dynamic> data,
  ) {
    return UserEntity(
      user: user,
      uid: data['uid'],
      favCity: data['favCity'],
      email: data['email'],
      username: data['username'],
    );
  }

  Map<String, dynamic> toDatabase() {
    return <String, dynamic>{
      'uid': uid,
      'favCity': favCity,
      'email': email,
      'username': username,
    };
  }
}
