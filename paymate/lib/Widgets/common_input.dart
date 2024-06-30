import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';



Widget commonTextField({
  required BuildContext context,
  required TextEditingController controller,
  required String hintText,
  required TextInputType keyBoardType,
  String? Function(String?)? validator,
  Key? key,
  int? maxLength,
  int? maxLine,
  FocusNode? focusNode,
  bool readOnly = false,
  VoidCallback? onTap,
  Function(String)? onChanged,
  Function(String)? onSubmitted,
  Function(String?)? onSaveText,
  Function()? onEditComplete,
  Function(PointerDownEvent)? onTapOutsideField,
  Color? backgroundColor,
  Widget? suffixIcon,
  Widget? prefixIcon,
  List<TextInputFormatter>? inputFormatter,
  double pLeft = 10.0,
  double pRight = 12.0,
  double pTop = 5.0,
  double pBottom = 0,
  double cLeft = 20,
  double cRight = 20,
  double cTop = 20,
  double cBottom = 20,
  double fntSize = 14,
  double radius = 12,
  bool isDanse = true,
  Color borderSideColor = Colors.transparent,
}) {
  return Padding(
    padding:
        EdgeInsets.only(left: pLeft, right: pRight, top: pTop, bottom: pBottom),
    child: Theme(
      data: ThemeData(
        hintColor: Colors.transparent,
        visualDensity: VisualDensity(
          horizontal: VisualDensity.minimumDensity,
        ),
      ),
      child: TextFormField(
        
        controller: controller,
        style: TextStyle(color: kSecondaryGreyTextColor, fontSize: fntSize),
        textAlign: TextAlign.left,
        readOnly: readOnly,
        focusNode: focusNode,
        onFieldSubmitted: onSubmitted,
       
        onSaved: onSaveText,
        onEditingComplete: onEditComplete,
        validator: validator ??
            (val) {
              return null;
            },
        inputFormatters: inputFormatter ?? [],
        onChanged: onChanged ?? (val) {},
        textAlignVertical: TextAlignVertical.center,
        keyboardType: keyBoardType,
        autocorrect: false,
        autofocus: false,
        maxLength: maxLength,
        maxLines: maxLine,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          isDense: isDanse,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderSideColor, width: 1),
            borderRadius: BorderRadius.circular(radius),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: textFieldBorderColor, width: 1),
            borderRadius: BorderRadius.circular(radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: textFieldBorderColor, width: 1),
            borderRadius: BorderRadius.circular(radius),
          ),
          fillColor: backgroundColor ?? colorGrey4,
          focusColor: focustextFieldColor,
          hintText: hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: textFieldLabelTextColor,
          ),
          suffixIcon: suffixIcon ?? null,
          prefixIcon: prefixIcon ?? null,
        ),
        onTap: onTap ?? () {},
      ),
    ),
  );
}
