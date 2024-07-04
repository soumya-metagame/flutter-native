class FetchLoggedInUserResponse {
  final String message;
  final String code;
  final Map<String, dynamic>? data;

  FetchLoggedInUserResponse(
      {required this.message, required this.code, this.data});

  factory FetchLoggedInUserResponse.fromJson(Map<String, dynamic> json) {
    return FetchLoggedInUserResponse(
        message: json['message'], code: json['code'], data: json['data']);
  }
}
