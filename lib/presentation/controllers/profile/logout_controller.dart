import 'package:crashorcash/data/datesources/remote/player/terminate-session.dart';
import 'package:crashorcash/domain/models/res/terminate-session-res.dart';
// import 'package:crashorcash/domain/models/res/terminate-session-res.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:get/get.dart';

class LogoutController extends GetxController {
  UserTokenManager userTokenManager = UserTokenManager();
  bool loading = false;
  var me = UserTokenManager().user;

  Future<TerminateSessionResponse> logout() async {
    userTokenManager.clearTokens();

    final response = await terminateSession(me['phoneNumber']);

    return response as TerminateSessionResponse;
  }
}
