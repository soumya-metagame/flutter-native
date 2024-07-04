class InitiateVerificationModel {
  final String phoneNumber;

  InitiateVerificationModel({required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {"phoneNumber": phoneNumber};
  }
}
