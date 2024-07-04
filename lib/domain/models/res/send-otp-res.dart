class InitiateVerificationResponse {
  final String message;
  final String code;
  final Map<String, dynamic>? data;

  InitiateVerificationResponse(
      {required this.message, required this.code, this.data});

  factory InitiateVerificationResponse.fromJson(Map<String, dynamic> json) {
    return InitiateVerificationResponse(
        message: json['message'], code: json['code'], data: json['data']);
  }
}
