import 'package:crashorcash/data/datesources/remote/payment/deposit.dart';
import 'package:crashorcash/domain/models/res/deposit_res.dart';
import 'package:crashorcash/utils/helpers/api_response.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:get/get.dart';

class DepositController extends GetxController {
  UserTokenManager userTokenManager = UserTokenManager();
  bool loading = false;
  var me = UserTokenManager().user;

  Rx<ApiResponse<DepositResponseModel>> response =
      ApiResponse<DepositResponseModel>().obs;

  Future<ApiResponse<DepositResponseModel>> createDeposit(String amount) async {
    try {
      final depositResponse = await deposit(
        me['_id'],
        me['name']?.trimRight() ??
            "John Doe", // Changed trimEnd() to trimRight()
        me['phoneNumber'].toString(),
        int.parse(amount),
        me['email']?.trimRight() ?? "john.doe@example.com",
        "DEPOSIT",
        "crashncash",
        "gifton",
        me['city']?.trimRight() ?? "Brooklyn",
        me['state']?.trimRight() ?? "San Francisco",
        me['country']?.trimRight() ?? "United States",
        me['zipCode']?.trimRight() ?? "123456",
      ) as ApiResponse<DepositResponseModel>;

      response.value = depositResponse;
      return depositResponse;
    } catch (e) {
      print(e);
      return ApiResponse<DepositResponseModel>.error("An error occurred");
    }
  }
}
