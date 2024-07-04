import 'package:crashorcash/domain/models/req/terminate-session.dart';
import 'package:crashorcash/domain/models/res/terminate-session-res.dart';
import 'package:crashorcash/utils/constants/app_constants.dart';
import 'package:dio/dio.dart';

Future<Object> terminateSession(String phoneNumber) async {
  final dio = Dio();

  const baseUrl = AppConstants.baseUrl;

  const apiUrl = '$baseUrl/core/auth/terminate-session';

  try {
    final request = TerminateSessionModel(phoneNumber: phoneNumber);

    final response = await dio.post(apiUrl, data: request.toJson());

    final responseData = TerminateSessionResponse.fromJson(response.data);

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
