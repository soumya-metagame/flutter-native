class DepositResponseModel {
  final String url;

  DepositResponseModel({required this.url});

  factory DepositResponseModel.fromJson(Map<String, dynamic> json) {
    return DepositResponseModel(
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}
