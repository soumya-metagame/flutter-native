import 'package:crashorcash/data/datesources/remote/payment/fetch_transaction_by_orderId.dart';
import 'package:crashorcash/utils/helpers/api_response.dart';
import 'package:get/get.dart';

class FetchTransactionByOrderidController extends GetxController {
  Future<ApiResponse> fetchTransaction(String orderId) async {
    try {
      final transaction =
          await fetchTransactionByOrderId(orderId) as ApiResponse;

      return transaction;
    } catch (e) {
      return ApiResponse.error(
          "An error occurred while fetching transaction by order with orderId: $orderId");
    }
  }
}
