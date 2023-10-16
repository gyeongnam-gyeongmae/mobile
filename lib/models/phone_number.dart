class PhoneVerificationModel {
  final String phoneNumber;

  PhoneVerificationModel({
    required this.phoneNumber,
  });

  factory PhoneVerificationModel.fromJson(Map<String, dynamic> json) {
    return PhoneVerificationModel(
      phoneNumber: json['phoneNumber'],
    );
  }
}
