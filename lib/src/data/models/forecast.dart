import 'dart:convert';

import 'package:weather_app/src/data/models/city.dart';
import 'package:weather_app/src/data/models/forecast_item.dart';

class Forecast {
  final String? cod;
  final int? message;
  final int? cnt;
  final List<ForecastItem>? list;
  final City? city;

  Iterable<ForecastItem> findItemForecast(String? tab) =>
      list?.where((e) {
        final findWeather = e.weather
            ?.where((eW) => eW.main?.toLowerCase() == tab?.toLowerCase());
        return findWeather?.isNotEmpty ?? false;
      }) ??
      [];

  Forecast({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  Forecast copyWith({
    String? cod,
    int? message,
    int? cnt,
    List<ForecastItem>? list,
    City? city,
  }) =>
      Forecast(
        cod: cod ?? this.cod,
        message: message ?? this.message,
        cnt: cnt ?? this.cnt,
        list: list ?? this.list,
        city: city ?? this.city,
      );

  factory Forecast.fromJson(String str) => Forecast.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Forecast.fromMap(Map<String, dynamic> json) => Forecast(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: json["list"] == null
            ? []
            : List<ForecastItem>.from(
                json["list"]!.map((x) => ForecastItem.fromMap(x))),
        city: json["city"] == null ? null : City.fromMap(json["city"]),
      );

  Map<String, dynamic> toMap() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list":
            list == null ? [] : List<dynamic>.from(list!.map((x) => x.toMap())),
        "city": city?.toMap(),
      };
}
