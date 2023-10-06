class MapModel {
  final String state;
  final String city;
  final String town;

  MapModel({
    required this.state,
    required this.city,
    required this.town,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
      state: json['state'] as String,
      city: json['city'] as String,
      town: json['town'] != null ? json['town'] as String : 'a',
    );
  }
}
