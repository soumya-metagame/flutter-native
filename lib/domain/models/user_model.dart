import 'package:crashorcash/domain/models/balance_model.dart';
import 'package:crashorcash/domain/models/kyc_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? role;

  @HiveField(3)
  BalanceModel balance;

  @HiveField(4)
  String skinId;

  @HiveField(5)
  String? name;

  @HiveField(6)
  String? source;

  @HiveField(7)
  String phoneNumber;

  @HiveField(8)
  String? city;

  @HiveField(9)
  String? state;

  @HiveField(10)
  String? country;

  @HiveField(11)
  String? zipCode;

  @HiveField(12)
  KycModel kyc;

  @HiveField(13)
  String? addressLine1;

  @HiveField(14)
  String? addressLine2;

  @HiveField(15)
  List<dynamic>? bankDetails;

  @HiveField(14)
  List<dynamic>? tags;

  UserModel({
    required this.id,
    this.email,
    this.role,
    required this.balance,
    required this.skinId,
    this.name,
    this.source,
    required this.phoneNumber,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    required this.kyc,
    this.addressLine1,
    this.addressLine2,
    this.bankDetails,
    this.tags,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        email = json['email'],
        role = json['role'],
        balance = BalanceModel.fromJson(json['balance']),
        skinId = json['skinId'],
        name = json['name'],
        source = json['source'],
        phoneNumber = json['phoneNumber'],
        city = json['city'],
        state = json['state'],
        country = json['country'],
        zipCode = json['zipCode'],
        kyc = KycModel.fromJson(json['kyc']),
        addressLine1 = json['addressLine1'],
        addressLine2 = json['addressLine2'],
        tags = json['tags'],
        bankDetails = json['bankDetails'];

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'role': role,
      'balance': balance.toJson(),
      'skinId': skinId,
      'name': name,
      'source': source,
      'phoneNumber': phoneNumber,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'kyc': kyc.toJson(),
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'tags': tags,
      'bankDetails': bankDetails,
    };
  }
}
