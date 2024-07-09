import 'package:crashorcash/domain/models/req/update_profile.dart';
import 'package:crashorcash/utils/helpers/api_response.dart';
import 'package:crashorcash/utils/helpers/api_service.dart';
import 'package:dio/dio.dart';

Future<Object> updateProfile(String name, String email, String phoneNumber,
    {String? password}) async {
  const apiUrl = '/core/player/update';

  try {
    final request = UpdateProfileModel(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      password: password ?? "",
    );

    print(request.toJson());

    final response = await ApiService.instance.request(
        '$apiUrl?updateBy=phoneNumber', DioMethod.patch,
        formData: request.toJson());

    final responseData = ApiResponse.fromJson(response.data, null);

    print("RESPONSE ${responseData.code}");

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
