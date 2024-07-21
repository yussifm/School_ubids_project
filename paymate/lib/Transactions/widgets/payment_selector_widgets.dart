import 'package:flutter/material.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';

class PaymentSelectorWidget extends StatelessWidget {
  PaymentSelectorWidget({
    Key? key,
    required this.deviceSize,
    required this.title,
    required this.imgsrc,
    required this.isSelected,
    required this.color,
  }) : super(key: key);

  final Size deviceSize;
  String title;
  String imgsrc;
  bool isSelected;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceSize.width * 0.43,
      height: 180,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color.withOpacity(0.3),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 8,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              imgsrc,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: kDarkPurpleColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
