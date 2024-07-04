import 'package:hive_flutter/hive_flutter.dart';

class KycModel extends HiveObject {
  @HiveField(0)
  bool isVerified;

  @HiveField(1)
  String kycStatus;

  KycModel({
    required this.isVerified,
    required this.kycStatus,
  });

  KycModel.fromJson(Map<String, dynamic> json)
      : isVerified = json['isVerified'],
        kycStatus = json['kycStatus'];

  Map<String, dynamic> toJson() {
    return {'isVerified': isVerified, "kycStatus": kycStatus};
  }
}
