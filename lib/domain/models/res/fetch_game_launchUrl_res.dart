// ignore: file_names
class FetchGameLaunchUrlResponse {
  final String message;
  final String code;
  final Map<String, dynamic>? data;

  FetchGameLaunchUrlResponse({
    required this.message,
    required this.code,
    this.data,
  });

  factory FetchGameLaunchUrlResponse.fromJson(Map<String, dynamic> json) {
    return FetchGameLaunchUrlResponse(
      message: json['message'] ?? '',
      code: json['code'] ?? '',
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  // Optional: Add a method to retrieve the game launch URL directly from data
  String get launchUrl => data?['link'];
}
