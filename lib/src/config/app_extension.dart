import 'package:dio/dio.dart';

extension NetworkResponse on Response {
  bool get ok => ((statusCode ?? 0) ~/ 100) == 2;

  bool get unAuthorized => (statusCode ?? 0) == 412;
}
