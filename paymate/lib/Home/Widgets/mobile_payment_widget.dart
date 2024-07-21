// mobile_payment_widget.dart

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paymate/Models/mobile_pay_model.dart';

List<List<Color>> gradientColors = [
  [const Color(0xFF353FDE), const Color(0xFF22264C)], // Example gradient
  [const Color(0xFFFE6F21), const Color(0xFFFFA500)], // Example gradient
  [const Color(0xFF7B4AE4), const Color(0xFF6A1B9A)], // Example gradient
  [const Color(0xFF8F90A7), const Color(0xFF707070)], // Example gradient
  [const Color(0xFF00BCD4), const Color(0xFF009688)], // Example gradient
];

List<Color> getRandomGradientColors() {
  Random random = Random();
  return gradientColors[random.nextInt(gradientColors.length)];
}

class MobilePaymentWidget extends StatelessWidget {
  final MobilePaymentModel mobilePayment;

  MobilePaymentWidget({required this.mobilePayment});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    List<Color> gradientColor = getRandomGradientColors();

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: deviceSize.width * 0.9,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage("assets/images/1968.jpg"),
          fit: BoxFit.fill,
          opacity: 0.4,
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.modulate,
          ),
        ),
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            mobilePayment.userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Phone Number',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            mobilePayment.phoneNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Provider',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            mobilePayment.provider,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
