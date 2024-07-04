import 'token_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'user_model.dart';

class UserTokenModel extends HiveObject {
  @HiveField(0)
  UserModel? data;

  @HiveField(1)
  TokenModel? token;

  UserTokenModel({this.data, this.token});

  factory UserTokenModel.fromJson(Map<String, dynamic> json) {
    return UserTokenModel(
      data: UserModel.fromJson(json['user']),
      token: TokenModel.fromJson(json['token']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': data?.toJson(),
      'token': token?.toJson(),
    };
  }
}
