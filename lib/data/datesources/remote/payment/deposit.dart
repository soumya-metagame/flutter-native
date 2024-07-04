import 'package:crashorcash/domain/models/req/deposit.dart';
import 'package:crashorcash/domain/models/res/deposit_res.dart';
import 'package:crashorcash/utils/helpers/api_response.dart';
// import 'package:crashorcash/utils/constants/app_constants.dart';
import 'package:crashorcash/utils/helpers/api_service.dart';
// import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

Future<Object> deposit(
    String userId,
    String customerName,
    String mobileNumber,
    int amount,
    String email,
    String transactionType,
    String skinId,
    String selection,
    String city,
    String state,
    String country,
    String zipCode) async {
  const apiUrl = '/payment/deposit';

  try {
    final request = DepositModel(
      userId: userId,
      customerName: customerName,
      mobileNumber: mobileNumber,
      amount: amount,
      email: email,
      transactionType: transactionType,
      skinId: skinId,
      selection: selection,
      city: city,
      state: state,
      country: country,
      zipCode: zipCode,
    );

    final response = await ApiService.instance
        .request(apiUrl, DioMethod.post, formData: request.toJson());

    final responseData = ApiResponse<DepositResponseModel>.fromJson(
        response.data, (data) => DepositResponseModel.fromJson(data['data']));

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
