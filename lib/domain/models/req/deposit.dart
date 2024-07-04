class DepositModel {
  String userId;
  String customerName;
  String mobileNumber;
  int amount;
  String email;
  String transactionType;
  // returnUrl: Joi.string().required().uri(),
  String skinId;
  String selection;
  String city;
  String state;
  String country;
  String zipCode;

  DepositModel({
    required this.userId,
    required this.customerName,
    required this.mobileNumber,
    required this.amount,
    required this.email,
    required this.transactionType,
    required this.skinId,
    required this.selection,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'customerName': customerName,
      'mobileNumber': mobileNumber,
      'amount': amount,
      'email': email,
      'transactionType': transactionType,
      'skinId': skinId,
      'selection': selection,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
    };
  }
}
