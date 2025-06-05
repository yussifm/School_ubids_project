// lib/onboarding/onboarding_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider extends ChangeNotifier {
  static const _prefsKey = 'seenOnboarding';

  bool _isLoading = true;
  bool _seen = false;

  /// True while loading from SharedPreferences
  bool get isLoading => _isLoading;

  /// True if onboarding has already been completed
  bool get seen => _seen;

  OnboardingProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _seen = prefs.getBool(_prefsKey) ?? false;
    _isLoading = false;
    notifyListeners();
  }

  /// Call this once the user finishes onboarding
  Future<void> markSeen() async {
    _seen = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, true);
  }

  /// Call this on logout to force onboarding next time
  Future<void> reset() async {
    _seen = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, false);
  }
}
