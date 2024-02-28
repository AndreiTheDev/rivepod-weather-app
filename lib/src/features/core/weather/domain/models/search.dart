// ignore_for_file: avoid_dynamic_calls

import 'package:freezed_annotation/freezed_annotation.dart';

part 'search.freezed.dart';

@freezed
class SearchModel with _$SearchModel {
  factory SearchModel({
    required final String city,
    required final String temp,
    required final int iconId,
    required final String username,
    required final String uid,
    required final String email,
    required final bool isMetricUnits,
    @Default(false) final bool isIncognito,
  }) = _SearchModel;

  SearchModel._();

  factory SearchModel.fromData(final Map<String, dynamic> data) {
    return SearchModel(
      city: data['weather']['city'],
      temp: data['weather']['temp'],
      iconId: data['weather']['iconId'],
      isMetricUnits: data['weather']['isMetricUnits'],
      username: data['user']['username'],
      email: data['user']['email'],
      uid: data['user']['uid'],
      isIncognito: data['isIncognito'] ?? false,
    );
  }
}
