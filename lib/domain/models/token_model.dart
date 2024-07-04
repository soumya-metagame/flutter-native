import 'package:hive_flutter/hive_flutter.dart';

class TokenModel {
  @HiveField(0)
  String accessToken;

  TokenModel({required this.accessToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['accessToken'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'accessToken': accessToken};
  }
}
