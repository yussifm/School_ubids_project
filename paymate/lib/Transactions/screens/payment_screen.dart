import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final bool isCardView;
  final bool isQrCode;
  const PaymentScreen({
    Key? key,
    required this.isCardView,
    required this.isQrCode,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
