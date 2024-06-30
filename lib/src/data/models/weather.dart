import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:weather_app/src/data/models/clouds.dart';
import 'package:weather_app/src/data/models/coord.dart';
import 'package:weather_app/src/data/models/main_element.dart';
import 'package:weather_app/src/data/models/sys.dart';
import 'package:weather_app/src/data/models/weather_element.dart';
import 'package:weather_app/src/data/models/wind.dart';

class Weather extends Equatable {
  final Coord? coord;
  final List<WeatherElement>? weather;
  final String? baseWeather;
  final MainElement? main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  const Weather({
    this.coord,
    this.weather,
    this.baseWeather,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  @override
  List<Object?> get props => [
        coord,
        weather,
        baseWeather,
        main,
        visibility,
        wind,
        clouds,
        dt,
        sys,
        timezone,
        id,
        name,
        cod,
      ];

  Weather copyWith({
    Coord? coord,
    List<WeatherElement>? weather,
    String? baseWeather,
    MainElement? main,
    int? visibility,
    Wind? wind,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) =>
      Weather(
        coord: coord ?? this.coord,
        weather: weather ?? this.weather,
        baseWeather: baseWeather ?? this.baseWeather,
        main: main ?? this.main,
        visibility: visibility ?? this.visibility,
        wind: wind ?? this.wind,
        clouds: clouds ?? this.clouds,
        dt: dt ?? this.dt,
        sys: sys ?? this.sys,
        timezone: timezone ?? this.timezone,
        id: id ?? this.id,
        name: name ?? this.name,
        cod: cod ?? this.cod,
      );

  factory Weather.fromJson(String str) => Weather.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        coord: json["coord"] == null ? null : Coord.fromMap(json["coord"]),
        weather: json["weather"] == null
            ? []
            : List<WeatherElement>.from(
                json["weather"]!.map((x) => WeatherElement.fromMap(x))),
        baseWeather: json["base"],
        main: json["main"] == null ? null : MainElement.fromMap(json["main"]),
        visibility: json["visibility"],
        wind: json["wind"] == null ? null : Wind.fromMap(json["wind"]),
        clouds: json["clouds"] == null ? null : Clouds.fromMap(json["clouds"]),
        dt: json["dt"],
        sys: json["sys"] == null ? null : Sys.fromMap(json["sys"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
      );

  Map<String, dynamic> toMap() => {
        "coord": coord?.toMap(),
        "weather": weather == null
            ? []
            : List<dynamic>.from(weather!.map((x) => x.toMap())),
        "base": baseWeather,
        "main": main?.toMap(),
        "visibility": visibility,
        "wind": wind?.toMap(),
        "clouds": clouds?.toMap(),
        "dt": dt,
        "sys": sys?.toMap(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
      };
}
