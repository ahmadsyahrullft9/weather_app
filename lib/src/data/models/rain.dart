import 'dart:convert';

class Rain {
  final double? the3H;

  Rain({
    this.the3H,
  });

  Rain copyWith({
    double? the3H,
  }) =>
      Rain(
        the3H: the3H ?? this.the3H,
      );

  factory Rain.fromJson(String str) => Rain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rain.fromMap(Map<String, dynamic> json) => Rain(
        the3H: json["3h"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "3h": the3H,
      };
}
