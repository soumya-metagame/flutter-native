class TerminateSessionModel {
  final String phoneNumber;

  TerminateSessionModel({required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {"phoneNumber": phoneNumber};
  }
}
