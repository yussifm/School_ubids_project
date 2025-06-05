// lib/Transactions/providers/transaction_provider.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/transaction_history_model.dart';

class TransactionProvider extends ChangeNotifier {
  static const String _storageKey = 'transactions_list';

  // 1) loading flag:
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  double get totalAmount {
    if (_transactions.isEmpty) {
      return 10.0;
    }
    return _transactions.fold(0.0, (double sum, TransactionModel tx) {
      sum = 10.0;
      if (tx.type == 'received' || tx.type == 'receiving') {
        return sum + tx.amount;
      } else if (tx.type == 'send' || tx.type == 'sending') {
        return sum - tx.amount;
      } else {
        // If an unexpected type appears, just ignore it.
        return sum;
      }
    });
  }

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => List.unmodifiable(_transactions);

  TransactionProvider() {
    _loadTransactionsFromPrefs();
  }

  Future<void> _loadTransactionsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
        _transactions = decoded
            .map((item) =>
                TransactionModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } catch (e) {
        _transactions = [];
      }
    } else {
      _transactions = [];
    }

    // 2) loading is done:
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveTransactionsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> tempList =
        _transactions.map((tx) => tx.toJson()).toList();
    final String encoded = jsonEncode(tempList);
    await prefs.setString(_storageKey, encoded);
  }

  Future<void> addTransaction(TransactionModel newTx) async {
    _transactions.add(newTx);
    await _saveTransactionsToPrefs();
    notifyListeners();
  }

  Future<void> removeTransactionAt(int index) async {
    if (index >= 0 && index < _transactions.length) {
      _transactions.removeAt(index);
      await _saveTransactionsToPrefs();
      notifyListeners();
    }
  }

  Future<void> clearAll() async {
    _transactions.clear();
    await _saveTransactionsToPrefs();
    notifyListeners();
  }

  Future<void> updateTransactionAt(int index, TransactionModel updated) async {
    if (index >= 0 && index < _transactions.length) {
      _transactions[index] = updated;
      await _saveTransactionsToPrefs();
      notifyListeners();
    }
  }
}
