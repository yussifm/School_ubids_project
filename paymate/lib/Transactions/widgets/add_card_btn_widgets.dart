import 'package:flutter/material.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddCardBtnWidgets extends StatelessWidget {
  const AddCardBtnWidgets({
    super.key,
    required this.deviceSize,
  });

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize.width * 0.8,
      height: 180,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kDarkPurpleColor,
      ),
      child: const Icon(
        PhosphorIconsBold.plusCircle,
        color: Colors.white,
        size: 60,
      ),
    );
  }
}
