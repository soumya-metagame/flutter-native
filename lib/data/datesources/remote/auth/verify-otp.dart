import 'package:crashorcash/domain/models/req/verify-otp.dart';
import 'package:crashorcash/domain/models/res/verify-otp-res.dart';
import 'package:crashorcash/utils/constants/app_constants.dart';
import 'package:dio/dio.dart';

Future<Object> verifyOtp(
    String phoneNumber, String otp, String deviceId) async {
  final dio = Dio();

  const baseUrl = AppConstants.baseUrl;

  const apiUrl = '$baseUrl/core/auth/otp/verify-otp';

  try {
    final request =
        VerifyOtpModel(phoneNumber: phoneNumber, otp: otp, deviceId: deviceId);

    final response = await dio.post(apiUrl, data: request.toJson());

    final responseData = VerifyOTPResponse.fromJson(response.data);

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
