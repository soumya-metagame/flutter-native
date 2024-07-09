class UpdateProfileModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String? password;

  UpdateProfileModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.password,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
    if (password != null && password!.isNotEmpty) {
      data['password'] = password;
    }
    return data;
  }
}
