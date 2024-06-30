import 'dart:convert';

class WeatherElement {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  WeatherElement({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  WeatherElement copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) =>
      WeatherElement(
        id: id ?? this.id,
        main: main ?? this.main,
        description: description ?? this.description,
        icon: icon ?? this.icon,
      );

  factory WeatherElement.fromJson(String str) =>
      WeatherElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WeatherElement.fromMap(Map<String, dynamic> json) => WeatherElement(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}
