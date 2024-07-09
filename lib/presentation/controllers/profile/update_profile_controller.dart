import 'package:crashorcash/data/datesources/remote/player/update_profile.dart';
import 'package:crashorcash/utils/helpers/api_response.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  var me = UserTokenManager().user;

  Future updateUserProfile(String name, String email,
      {String? password}) async {
    try {
      print("=====");
      final response = await updateProfile(name, email, me['phoneNumber'],
          password: password);

      print("=============================");

      return response;
    } catch (e) {
      return ApiResponse.error("Something went wrong");
    }
  }
}
