import 'package:crashorcash/domain/models/req/fetch_game_launchUrl.dart';
import 'package:crashorcash/domain/models/res/fetch_game_launchUrl_res.dart';
import 'package:crashorcash/utils/constants/app_constants.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:dio/dio.dart';

Future<Object> fetchGameLaunchUrl(String gameId) async {
  final dio = Dio();

  const baseUrl = AppConstants.baseUrl;

  const apiUrl = '$baseUrl/core/game/launchUrl';

  final token = UserTokenManager().accessToken;

  try {
    final request = FetchGameLaunchUrlModel(gameId: gameId, token: token);

    final response = await dio.post(apiUrl,
        data: request.toJson(),
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json"
        }));

    final responseData = FetchGameLaunchUrlResponse.fromJson(response.data);

    return responseData;
  } on DioException catch (e) {
    print("Error: $e");
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
