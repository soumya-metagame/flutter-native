import 'package:crashorcash/domain/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserTokenManager {
  static UserTokenManager _instance = UserTokenManager();

  static UserTokenManager get instance {
    _instance ??= UserTokenManager();
    return _instance;
  }

  Box get _db {
    return Hive.box("user");
  }

  Future<void> setToken({required String accessToken}) async {
    // TokenModel token = TokenModel(accessToken: accessToken);

    print("ACCESS_TOKEN: $accessToken");
    _db.put("token", accessToken);
  }

  Future<void> setUserData(Map<String, dynamic> data) async {
    UserModel user = UserModel.fromJson(data);

    _db.put("me", user.toJson());
  }

  static Future<bool> hasAccessToken() async {
    var box = await Hive.openBox("user");
    // print("TOKEN----------------$token");
    return box.containsKey("token") && box.containsKey("me");
  }

  Future<void> clearTokens() async {
    _db.delete("token");
    _db.delete("me");
  }

  get accessToken {
    return _db.get("token");
  }

  get user {
    return _db.get("me");
  }
}
