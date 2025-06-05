// transaction_history_widget.dart

import 'package:flutter/material.dart';

import '../../Models/transaction_history_model.dart';



class TransactionHistoryWidget extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionHistoryWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: transaction.type == 'send'
                ? Colors.redAccent
                : Colors.greenAccent,
            child: Icon(
              transaction.icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'On ${transaction.dateTime}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  transaction.type == 'send' ? 'Send' : 'Received',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        transaction.type == 'send'
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'GHC${transaction.amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
