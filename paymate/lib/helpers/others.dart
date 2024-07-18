import 'package:flutter/services.dart';

void setStatusBarColor(Color color, Brightness b) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: color, statusBarIconBrightness: b),
  );
}
