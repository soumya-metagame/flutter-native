class TerminateSessionResponse {
  final String message;
  final String code;
  final Map<String, dynamic>? data;

  TerminateSessionResponse(
      {required this.message, required this.code, this.data});

  factory TerminateSessionResponse.fromJson(Map<String, dynamic> json) {
    return TerminateSessionResponse(
        message: json['message'], code: json['code'], data: json['data']);
  }
}
