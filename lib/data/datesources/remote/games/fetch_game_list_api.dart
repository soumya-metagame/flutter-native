import 'package:crashorcash/domain/models/res/fetch_game_list.dart';
// import 'package:crashorcash/utils/constants/app_constants.dart';
import 'package:crashorcash/utils/helpers/api_service.dart';
// import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

Future<Object> fetchGameList() async {
  const apiUrl = '/core/game/list';

  try {
    final response = await ApiService.instance.request(apiUrl, DioMethod.get);

    // print("RESPONSE---------------------------------------------------");
    // print(response.data);

    final responseData = GameListResponseModel.fromJson(response.data);

    return responseData;
  } on DioException catch (e) {
    print("Error: $e");
    Get.offAllNamed("/auth");
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
