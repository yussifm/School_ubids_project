// lib/Providers/user_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A ChangeNotifier that holds the current user name (and any other profile details
/// you may want to add later). It automatically loads from SharedPreferences on
/// creation, and saves to SharedPreferences whenever you update.
class UserProvider extends ChangeNotifier {
  static const String _prefsKeyUserName = 'user_name';

  String _userName = 'UserName';  // default value
  bool _isLoading = true;
  
  /// Whether the provider is still loading initial data from SharedPreferences.
  bool get isLoading => _isLoading;

  /// The current user name. Always non-null.
  String get userName => _userName;

  UserProvider() {
    _loadUserFromPrefs();
  }

  /// Private: load from SharedPreferences once, then mark loading = false.
  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString(_prefsKeyUserName) ?? 'UserName';
    _userName = savedName;
    _isLoading = false;
    notifyListeners();
  }

  /// Call this to update the userName. It will (1) update local state (2) write to SharedPreferences (3) notify listeners.
  Future<void> setUserName(String newName) async {
    if (newName.trim().isEmpty) return;
    _userName = newName.trim();
    notifyListeners(); // update any listeners immediately
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKeyUserName, _userName);
  }
}
