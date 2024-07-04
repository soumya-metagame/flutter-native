import 'package:crashorcash/domain/models/req/send-otp.dart';
import 'package:crashorcash/domain/models/res/send-otp-res.dart';
import 'package:crashorcash/utils/constants/app_constants.dart';
import 'package:dio/dio.dart';

Future<Object> initiateVerification(String phoneNumber) async {
  final dio = Dio();

  const baseUrl = AppConstants.baseUrl;

  const apiUrl = '$baseUrl/core/auth/otp/send-otp';

  try {
    final request = InitiateVerificationModel(phoneNumber: phoneNumber);

    final response = await dio.post(apiUrl, data: request.toJson());

    final responseData = InitiateVerificationResponse.fromJson(response.data);

    if (responseData.code == 'L200') {
      return responseData;
    } else {
      return response;
    }
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
