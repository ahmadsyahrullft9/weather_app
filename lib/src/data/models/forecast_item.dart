import 'dart:convert';

import 'package:weather_app/src/data/models/clouds.dart';
import 'package:weather_app/src/data/models/main_element.dart';
import 'package:weather_app/src/data/models/rain.dart';
import 'package:weather_app/src/data/models/sys.dart';
import 'package:weather_app/src/data/models/weather_element.dart';
import 'package:weather_app/src/data/models/wind.dart';

class ForecastItem {
  final int? dt;
  final MainElement? main;
  final List<WeatherElement>? weather;
  final Clouds? clouds;
  final Wind? wind;
  final int? visibility;
  final double? pop;
  final Rain? rain;
  final Sys? sys;
  final String? dtTxt;

  ForecastItem({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });

  ForecastItem copyWith({
    int? dt,
    MainElement? main,
    List<WeatherElement>? weather,
    Clouds? clouds,
    Wind? wind,
    int? visibility,
    double? pop,
    Rain? rain,
    Sys? sys,
    String? dtTxt,
  }) =>
      ForecastItem(
        dt: dt ?? this.dt,
        main: main ?? this.main,
        weather: weather ?? this.weather,
        clouds: clouds ?? this.clouds,
        wind: wind ?? this.wind,
        visibility: visibility ?? this.visibility,
        pop: pop ?? this.pop,
        rain: rain ?? this.rain,
        sys: sys ?? this.sys,
        dtTxt: dtTxt ?? this.dtTxt,
      );

  factory ForecastItem.fromJson(String str) =>
      ForecastItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ForecastItem.fromMap(Map<String, dynamic> json) => ForecastItem(
        dt: json["dt"],
        main: json["main"] == null ? null : MainElement.fromMap(json["main"]),
        weather: json["weather"] == null
            ? []
            : List<WeatherElement>.from(
                json["weather"]!.map((x) => WeatherElement.fromMap(x))),
        clouds: json["clouds"] == null ? null : Clouds.fromMap(json["clouds"]),
        wind: json["wind"] == null ? null : Wind.fromMap(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"]?.toDouble(),
        rain: json["rain"] == null ? null : Rain.fromMap(json["rain"]),
        sys: json["sys"] == null ? null : Sys.fromMap(json["sys"]),
        dtTxt: json["dt_txt"],
      );

  Map<String, dynamic> toMap() => {
        "dt": dt,
        "main": main?.toMap(),
        "weather": weather == null
            ? []
            : List<dynamic>.from(weather!.map((x) => x.toMap())),
        "clouds": clouds?.toMap(),
        "wind": wind?.toMap(),
        "visibility": visibility,
        "pop": pop,
        "rain": rain?.toMap(),
        "sys": sys?.toMap(),
        "dt_txt": dtTxt,
      };
}
