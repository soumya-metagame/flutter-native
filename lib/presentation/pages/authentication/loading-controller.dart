import 'package:get/get.dart';

class PhoneNumberInputController extends GetxController {
  RxBool isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }
}

class OtpInputController extends GetxController {
  RxBool isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }
}
