import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../apptheme/colors/colors_app.dart';

showLoader({Color? circleColor}) {
  return const Center(
    child: SizedBox(
      height: 50,
      width: 70,
      child: LoadingIndicator(
          indicatorType: Indicator.lineScale,
          colors: [kPrimaryColor, kDarkPurpleColor],
      ),
    ),
  );
}
