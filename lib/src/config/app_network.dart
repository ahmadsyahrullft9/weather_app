import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/src/config/app_extension.dart';

abstract class Rest {
  final serverUrl = "http://api.openweathermap.org/data/2.5/";
  final apiKey = "1b7eeecd2ff64dc83e8dcf1f4cb2102b";

  late Dio dio;

  final Map<String, String> multiPartHeader = {
    "Accept": "application/json",
    "Content-Type": "multipart/form-data"
  };

  Rest() {
    dio = DioClient.instance(serverUrl);
  }
}

class DioClient {
  static Dio? _dio;

  static Dio instance(String serverUrl) {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: serverUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
        validateStatus: (int? status) => status != null && status > 0,
      ),
    );
    (_dio?.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    _dio?.interceptors.add(ApiInterceptor());
    return _dio!;
  }
}

class ApiInterceptor extends QueuedInterceptor {
  _showLogging({required String title, required Map logData}) {
    final prettyString =
        const JsonEncoder.withIndent(' ').convert({title: logData});
    log("\n$prettyString\n");
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final logging = <String, dynamic>{};
    if (kDebugMode) {
      logging['url'] = "${options.uri}";
      logging['headers'] = options.headers;
      logging['method'] = options.method;
      _showLogging(title: "request", logData: logging);
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final logging = <String, dynamic>{};
    final mResponse = response;
    final statusCode = response.statusCode;

    if (kDebugMode) {
      Map<String, dynamic>? data;
      try {
        data = jsonDecode(response.toString());
      } catch (e) {
        return handler.reject(DioException(
          requestOptions: mResponse.requestOptions,
          error: e,
          message: "trying to get data response failded",
          stackTrace:
              StackTrace.fromString("trying to get data response failded"),
          response: mResponse,
          type: DioExceptionType.badResponse,
        ));
      }
      logging['url'] = response.realUri.toString();
      logging['code'] = statusCode;
      logging['data'] = data;
      _showLogging(title: "response", logData: logging);
    }

    if (response.ok) {
      return handler.resolve(response);
    } else {
      return handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final logging = <String, dynamic>{};
    if (kDebugMode) {
      logging['url'] = "${err.requestOptions.uri}";
      logging['type'] = err.type.name;
      logging['message'] = err.message;
      logging['error'] = err.error;
      _showLogging(title: "error", logData: logging);
    }
    return handler.reject(err);
  }
}
