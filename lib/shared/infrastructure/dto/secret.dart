// To parse this JSON data, do
//
//     final secret = secretFromJson(jsonString);

import 'dart:convert';

Secret secretFromJson(String str) => Secret.fromJson(json.decode(str));

String secretToJson(Secret data) => json.encode(data.toJson());

class Secret {
  String value;

  Secret({
    required this.value,
  });

  factory Secret.fromJson(Map<String, dynamic> json) => Secret(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}
