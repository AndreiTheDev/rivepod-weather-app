// ignore_for_file: avoid_dynamic_calls

class SearchModel {
  SearchModel({
    required this.city,
    required this.temp,
    required this.iconId,
    required this.username,
  });

  factory SearchModel.fromData(final Map<String, dynamic> data) {
    return SearchModel(
      city: data['weather']['city'],
      temp: data['weather']['temp'],
      iconId: data['weather']['iconId'],
      username: data['user']['username'],
    );
  }

  final String city;
  final String temp;
  final String username;
  final int iconId;
}
