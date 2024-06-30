import 'dart:convert';

class Coord {
  final double? lat;
  final double? lon;

  Coord({
    this.lat,
    this.lon,
  });

  Coord copyWith({
    double? lat,
    double? lon,
  }) =>
      Coord(
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
      );

  factory Coord.fromJson(String str) => Coord.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Coord.fromMap(Map<String, dynamic> json) => Coord(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lon": lon,
      };
}
