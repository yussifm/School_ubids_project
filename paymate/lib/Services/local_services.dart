import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
// import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class LocalAuthService {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          stickyAuth: true,
          biometricOnly: false,
        ),
        authMessages: const [
          AndroidAuthMessages(
            signInTitle: 'Oops! Biometric authentication required!',
          ),
          IOSAuthMessages(),
        ],
        localizedReason: 'Scan Face to Authenticate',
      );
    } on PlatformException {
      return false;
    }
  }
}
