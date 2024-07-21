// mobile_payment_model.dart

class MobilePaymentModel {
  final String phoneNumber;
  final String userName;
  final String provider;

  MobilePaymentModel(
      {required this.phoneNumber,
      required this.userName,
      required this.provider});
}
