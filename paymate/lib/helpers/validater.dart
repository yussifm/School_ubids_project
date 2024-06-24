import 'dart:math' as math;

import 'package:flutter/services.dart';

class Validator {
  /// Can be used with any type of common text fields like Name, Address String, etc.
  ///
  ///
  static String? validateWithdrawAmount(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Amount cannot be empty';
    }

    // Regular expression to match up to 2 decimal places
    RegExp regex = RegExp(r'^\d*\.?\d{0,2}$');

    if (!regex.hasMatch(value)) {
      return 'Invalid amount';
    }

    return null;
  }

  static String? commonValidator(
      {required String? val,
      required String? errorMessage,
      int? characterLimit,
      String? errorMessageForCharacter}) {
    if (val == null) {
      return null;
    }
    if (val.isEmpty) {
      return errorMessage;
    }
    if (characterLimit != null) {
      if (val.length < characterLimit) {
        return "Description Too short";
      }
    }
    return null;
  }

  static String? supportDescriptionCommonValidator(
      {required String? val,
      required String? errorMessage,
      int? characterLimit,
      int? characterMax,
      String? errorMessageForCharacter}) {
    if (val == null || val.isEmpty) {
      return 'Please enter some text.';
    }

    if (val.isEmpty) {
      return errorMessage;
    }

    // Split the text into words using a regular expression
    List<String> words = val.split(RegExp(r'\s+'));

    if (characterLimit != null) {
      if (words.length < characterLimit) {
        return 'Minimum of $characterLimit words required.';
      }
    }

    if (characterMax != null) {
      if (words.length > characterMax) {
        return 'Maximum of $characterMax words allowed.';
      }
    }

    // Validation passed
    return null;
  }

  static String? commonValidatorAmount(
      {required String? val,
      required String? errorMessage,
      int? characterLimit,
      String? errorMessageForCharacter}) {
    if (val == null) {
      return null;
    }
    if (val.isEmpty) {
      return errorMessage;
    }
    if (characterLimit != null) {
      if (val.length > characterLimit) {
        return errorMessageForCharacter ?? '';
      }
    }
    return null;
  }

  static String? referCodeValidator(
      {required String? val,
      required String? errorMessage,
      int? characterLimit,
      String? errorMessageForCharacter}) {
    if (characterLimit != null && val!.isNotEmpty) {
      if (val.length > characterLimit) {
        return errorMessageForCharacter ?? '';
      }
    }
    return null;
  }

  static String? validateConfirmPassword(
      {required String? password, required String? confirmPassword}) {
    if (confirmPassword == null) {
      return null;
    }
    if (confirmPassword.isEmpty) {
      return 'Confirm password can\'t be empty';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Can be used to validate email address with regex available
  static String? validateEmail({required String? val}) {
    if (val == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r'^[a-zA-Z0-9.]*@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (val.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(val)) {
      return 'Invalid email';
    }
    return null;
  }

  static String? validateDenomination({required String? val}) {
    if (val == null) {
      return null;
    }
    final RegExp r = RegExp(r'^(1[0-4][0-9]|150|10)$');

    if (val.isEmpty) {
      return 'denomination can\'t be empty';
    } else if (int.parse(val.toString()) < 10 ||
        int.parse(val.toString()) > 150) {
      return 'Please enter Price Range of \$10 - \$150';
    }
    return null;
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
