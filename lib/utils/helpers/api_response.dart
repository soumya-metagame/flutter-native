class ApiResponse<T> {
  final String? message;
  final String? code;

  final T? data;

  final bool isError;

  ApiResponse({this.message, this.code, this.data, this.isError = false});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse<T>(
      message: json['message'] ?? '',
      code: json['code'] ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  factory ApiResponse.error(String message) {
    return ApiResponse<T>(
        message: message, code: '', data: null, isError: true);
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'message': message,
      'code': code,
      'data': data != null ? toJsonT(data as T) : null,
    };
  }
}
