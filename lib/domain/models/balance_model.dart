import 'package:hive_flutter/hive_flutter.dart';

class BalanceModel extends HiveObject {
  @HiveField(0)
  num currentBalance;

  @HiveField(1)
  num withdrawalBalance;

  @HiveField(2)
  num bonusBalance;

  @HiveField(3)
  num inPlayBalance;

  BalanceModel({
    required this.currentBalance,
    required this.withdrawalBalance,
    required this.bonusBalance,
    required this.inPlayBalance,
  });

  BalanceModel.fromJson(Map<String, dynamic> json)
      : currentBalance = json['currentBalance'],
        withdrawalBalance = json['withdrawalBalance'],
        bonusBalance = json['bonusBalance'],
        inPlayBalance = json['inPlayBalance'];

  Map<String, dynamic> toJson() {
    return {
      'currentBalance': currentBalance,
      'withdrawalBalance': withdrawalBalance,
      'bonusBalance': bonusBalance,
      'inPlayBalance': inPlayBalance
    };
  }
}
