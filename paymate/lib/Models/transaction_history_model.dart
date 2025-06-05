import 'package:flutter/material.dart';

class TransactionModel {
  final String name;
  final String
      dateTime; // you could also store DateTime as an ISO string, but you already have this as String
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

  /// Convert an instance into a Map<String, dynamic> for JSON encoding.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dateTime': dateTime,
      'amount': amount,
      // For IconData, store codePoint and fontFamily.
      'icon': {
        'codePoint': icon.codePoint,
        'fontFamily': icon.fontFamily,
        // optionally, you could store fontPackage if using a custom icon pack
        'fontPackage': icon.fontPackage,
        // and also whether it’s matchTextDirection, if relevant:
        'matchTextDirection': icon.matchTextDirection,
      },
      'type': type,
    };
  }

  /// Reconstruct from a Map (decoded JSON).
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    final iconMap = json['icon'] as Map<String, dynamic>;
    return TransactionModel(
      name: json['name'] as String,
      dateTime: json['dateTime'] as String,
      amount: (json['amount'] as num).toDouble(),
      icon: IconData(
        iconMap['codePoint'] as int,
        fontFamily: iconMap['fontFamily'] as String?,
        fontPackage: iconMap['fontPackage'] as String?,
        matchTextDirection: iconMap['matchTextDirection'] as bool? ?? false,
      ),
      type: json['type'] as String,
    );
  }
}
