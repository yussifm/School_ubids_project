import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';


showToast({required String msg, Color? backgroundColor}) {
  return Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: backgroundColor ?? kPrimaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
}


showTopToast({required String msg, Color? backgroundColor}) {
  return Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: backgroundColor ?? kPrimaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
