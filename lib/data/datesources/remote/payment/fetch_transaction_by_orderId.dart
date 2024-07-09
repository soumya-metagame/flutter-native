import 'package:crashorcash/utils/helpers/api_response.dart';
import 'package:crashorcash/utils/helpers/api_service.dart';
import 'package:dio/dio.dart';

Future<Object> fetchTransactionByOrderId(String OrderId) async {
  final apiUrl = '/payment/deposit/transaction/$OrderId';

  try {
    final response = await ApiService.instance.request(apiUrl, DioMethod.get);

    final responseData = ApiResponse.fromJson(response.data, null);

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
