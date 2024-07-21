// transaction_model.dart

import 'package:flutter/material.dart';

class TransactionModel {
  final String name;
  final String dateTime;
  final double amount;
  final IconData icon;
  final String type; // either 'sending' or 'receiving'

  TransactionModel({
    required this.name,
    required this.dateTime,
    required this.amount,
    required this.icon,
    required this.type,
  });
}
