class VerifyOTPResponse {
  final String message;
  final String code;
  final Map<String, dynamic>? data;

  VerifyOTPResponse({required this.message, required this.code, this.data});

  factory VerifyOTPResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOTPResponse(
        message: json['message'], code: json['code'], data: json['data']);
  }
}
