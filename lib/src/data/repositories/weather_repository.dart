import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:weather_app/src/config/app_extension.dart';
import 'package:weather_app/src/config/app_network.dart';
import 'package:weather_app/src/data/models/error_response.dart';
import 'package:weather_app/src/data/models/forecast.dart';

import 'package:dartz/dartz.dart';
import 'package:weather_app/src/data/models/weather.dart';

class WeatherRepository extends Rest {
  WeatherRepository() : super();

  Future<Either<ErrorResponse, Forecast>> getForecast(int cityId) async {
    final response = await dio.get(
      "$serverUrl/forecast",
      queryParameters: {
        "id": cityId,
        "appid": apiKey,
      },
    );
    final json = jsonDecode(response.toString());
    if (response.ok) {
      final result = Forecast.fromMap(json);
      return Right(result);
    } else {
      final resultError = ErrorResponse.fromMap(json);
      debugPrint("forecast error ${resultError.message}");
      return Left(resultError);
    }
  }

  Future<Either<ErrorResponse, Weather>> getWeather(String cityName) async {
    final response = await dio.get(
      "$serverUrl/weather",
      queryParameters: {
        "q": cityName,
        "appid": apiKey,
      },
    );
    final json = jsonDecode(response.toString());
    if (response.ok) {
      final result = Weather.fromMap(json);
      return Right(result);
    } else {
      final resultError = ErrorResponse.fromMap(json);
      return Left(resultError);
    }
  }
}
