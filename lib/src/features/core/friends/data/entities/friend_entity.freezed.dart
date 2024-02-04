// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FriendEntity {
  String get email => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FriendEntityCopyWith<FriendEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendEntityCopyWith<$Res> {
  factory $FriendEntityCopyWith(
          FriendEntity value, $Res Function(FriendEntity) then) =
      _$FriendEntityCopyWithImpl<$Res, FriendEntity>;
  @useResult
  $Res call({String email, String uid, String username});
}

/// @nodoc
class _$FriendEntityCopyWithImpl<$Res, $Val extends FriendEntity>
    implements $FriendEntityCopyWith<$Res> {
  _$FriendEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? uid = null,
    Object? username = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendEntityImplCopyWith<$Res>
    implements $FriendEntityCopyWith<$Res> {
  factory _$$FriendEntityImplCopyWith(
          _$FriendEntityImpl value, $Res Function(_$FriendEntityImpl) then) =
      __$$FriendEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String uid, String username});
}

/// @nodoc
class __$$FriendEntityImplCopyWithImpl<$Res>
    extends _$FriendEntityCopyWithImpl<$Res, _$FriendEntityImpl>
    implements _$$FriendEntityImplCopyWith<$Res> {
  __$$FriendEntityImplCopyWithImpl(
      _$FriendEntityImpl _value, $Res Function(_$FriendEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? uid = null,
    Object? username = null,
  }) {
    return _then(_$FriendEntityImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FriendEntityImpl extends _FriendEntity {
  _$FriendEntityImpl(
      {required this.email, required this.uid, required this.username})
      : super._();

  @override
  final String email;
  @override
  final String uid;
  @override
  final String username;

  @override
  String toString() {
    return 'FriendEntity(email: $email, uid: $uid, username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendEntityImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, uid, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendEntityImplCopyWith<_$FriendEntityImpl> get copyWith =>
      __$$FriendEntityImplCopyWithImpl<_$FriendEntityImpl>(this, _$identity);
}

abstract class _FriendEntity extends FriendEntity {
  factory _FriendEntity(
      {required final String email,
      required final String uid,
      required final String username}) = _$FriendEntityImpl;
  _FriendEntity._() : super._();

  @override
  String get email;
  @override
  String get uid;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$FriendEntityImplCopyWith<_$FriendEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
