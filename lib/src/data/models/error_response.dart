import 'dart:convert';

class ErrorResponse {
  final String? cod;
  final String? message;

  ErrorResponse({
    this.cod,
    this.message,
  });

  ErrorResponse copyWith({
    String? cod,
    String? message,
  }) =>
      ErrorResponse(
        cod: cod ?? this.cod,
        message: message ?? this.message,
      );

  factory ErrorResponse.fromJson(String str) =>
      ErrorResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ErrorResponse.fromMap(Map<String, dynamic> json) => ErrorResponse(
        cod: json["cod"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "cod": cod,
        "message": message,
      };
}
