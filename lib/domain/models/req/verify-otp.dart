class VerifyOtpModel {
  final String phoneNumber;
  final String otp;
  final String deviceId;

  VerifyOtpModel(
      {required this.phoneNumber, required this.otp, required this.deviceId});

  Map<String, dynamic> toJson() {
    return {"phoneNumber": phoneNumber, "otp": otp, "deviceId": deviceId};
  }
}
