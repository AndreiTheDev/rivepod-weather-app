// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchModel {
  String get city => throw _privateConstructorUsedError;
  String get temp => throw _privateConstructorUsedError;
  int get iconId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get isMetricUnits => throw _privateConstructorUsedError;
  String get docId => throw _privateConstructorUsedError;
  bool get isIncognito => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchModelCopyWith<SearchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchModelCopyWith<$Res> {
  factory $SearchModelCopyWith(
          SearchModel value, $Res Function(SearchModel) then) =
      _$SearchModelCopyWithImpl<$Res, SearchModel>;
  @useResult
  $Res call(
      {String city,
      String temp,
      int iconId,
      String username,
      String uid,
      String email,
      bool isMetricUnits,
      String docId,
      bool isIncognito});
}

/// @nodoc
class _$SearchModelCopyWithImpl<$Res, $Val extends SearchModel>
    implements $SearchModelCopyWith<$Res> {
  _$SearchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = null,
    Object? temp = null,
    Object? iconId = null,
    Object? username = null,
    Object? uid = null,
    Object? email = null,
    Object? isMetricUnits = null,
    Object? docId = null,
    Object? isIncognito = null,
  }) {
    return _then(_value.copyWith(
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as String,
      iconId: null == iconId
          ? _value.iconId
          : iconId // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isMetricUnits: null == isMetricUnits
          ? _value.isMetricUnits
          : isMetricUnits // ignore: cast_nullable_to_non_nullable
              as bool,
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      isIncognito: null == isIncognito
          ? _value.isIncognito
          : isIncognito // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchModelImplCopyWith<$Res>
    implements $SearchModelCopyWith<$Res> {
  factory _$$SearchModelImplCopyWith(
          _$SearchModelImpl value, $Res Function(_$SearchModelImpl) then) =
      __$$SearchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String city,
      String temp,
      int iconId,
      String username,
      String uid,
      String email,
      bool isMetricUnits,
      String docId,
      bool isIncognito});
}

/// @nodoc
class __$$SearchModelImplCopyWithImpl<$Res>
    extends _$SearchModelCopyWithImpl<$Res, _$SearchModelImpl>
    implements _$$SearchModelImplCopyWith<$Res> {
  __$$SearchModelImplCopyWithImpl(
      _$SearchModelImpl _value, $Res Function(_$SearchModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = null,
    Object? temp = null,
    Object? iconId = null,
    Object? username = null,
    Object? uid = null,
    Object? email = null,
    Object? isMetricUnits = null,
    Object? docId = null,
    Object? isIncognito = null,
  }) {
    return _then(_$SearchModelImpl(
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as String,
      iconId: null == iconId
          ? _value.iconId
          : iconId // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isMetricUnits: null == isMetricUnits
          ? _value.isMetricUnits
          : isMetricUnits // ignore: cast_nullable_to_non_nullable
              as bool,
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      isIncognito: null == isIncognito
          ? _value.isIncognito
          : isIncognito // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SearchModelImpl extends _SearchModel {
  _$SearchModelImpl(
      {required this.city,
      required this.temp,
      required this.iconId,
      required this.username,
      required this.uid,
      required this.email,
      required this.isMetricUnits,
      required this.docId,
      this.isIncognito = false})
      : super._();

  @override
  final String city;
  @override
  final String temp;
  @override
  final int iconId;
  @override
  final String username;
  @override
  final String uid;
  @override
  final String email;
  @override
  final bool isMetricUnits;
  @override
  final String docId;
  @override
  @JsonKey()
  final bool isIncognito;

  @override
  String toString() {
    return 'SearchModel(city: $city, temp: $temp, iconId: $iconId, username: $username, uid: $uid, email: $email, isMetricUnits: $isMetricUnits, docId: $docId, isIncognito: $isIncognito)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchModelImpl &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.iconId, iconId) || other.iconId == iconId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isMetricUnits, isMetricUnits) ||
                other.isMetricUnits == isMetricUnits) &&
            (identical(other.docId, docId) || other.docId == docId) &&
            (identical(other.isIncognito, isIncognito) ||
                other.isIncognito == isIncognito));
  }

  @override
  int get hashCode => Object.hash(runtimeType, city, temp, iconId, username,
      uid, email, isMetricUnits, docId, isIncognito);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchModelImplCopyWith<_$SearchModelImpl> get copyWith =>
      __$$SearchModelImplCopyWithImpl<_$SearchModelImpl>(this, _$identity);
}

abstract class _SearchModel extends SearchModel {
  factory _SearchModel(
      {required final String city,
      required final String temp,
      required final int iconId,
      required final String username,
      required final String uid,
      required final String email,
      required final bool isMetricUnits,
      required final String docId,
      final bool isIncognito}) = _$SearchModelImpl;
  _SearchModel._() : super._();

  @override
  String get city;
  @override
  String get temp;
  @override
  int get iconId;
  @override
  String get username;
  @override
  String get uid;
  @override
  String get email;
  @override
  bool get isMetricUnits;
  @override
  String get docId;
  @override
  bool get isIncognito;
  @override
  @JsonKey(ignore: true)
  _$$SearchModelImplCopyWith<_$SearchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
