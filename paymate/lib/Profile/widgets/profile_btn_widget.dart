import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../apptheme/colors/colors_app.dart';

class ProfileBtnWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  bool isIcon;
  ProfileBtnWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.isIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: kDarkPurpleColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Visibility(
            visible: isIcon,
            child: const Icon(
              PhosphorIconsBold.caretRight,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
