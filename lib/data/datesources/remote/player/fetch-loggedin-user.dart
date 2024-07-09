import 'package:crashorcash/domain/models/res/fetch-loggedin-user-res.dart';
import 'package:crashorcash/utils/constants/app_constants.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:dio/dio.dart';

Future<Object> fetchLoggedinUser() async {
  final dio = Dio();

  const baseUrl = AppConstants.baseUrl;

  const apiUrl = '$baseUrl/core/player/me';

  final token = UserTokenManager().accessToken;
  // final accessToken = token.accessToken;

  try {
    final response = await dio.get(apiUrl,
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json"
        }));

    final responseData = FetchLoggedInUserResponse.fromJson(response.data);

    return responseData;
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response?.statusCode == 400) {
        print(e.response?.data);
        // authController.setMessage(e.response?.data['message']);
        return e.response?.data['message'];
      } else if (e.response?.statusCode == 500) {
        // authController.setMessage("Please check your network connection");
        return 'Network error';
      } else {
        return 'An error occurred';
      }
    } else {
      return 'An error occurred: ${e.message}';
    }
  }
}
