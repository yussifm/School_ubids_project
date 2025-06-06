// lib/Profile/screens/my_earnings_payout_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:paymate/Models/transaction_history_model.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../Transactions/providers_transaction.dart';

class MyEarningsPayoutScreen extends StatelessWidget {
  const MyEarningsPayoutScreen({super.key});

  bool _isReceiving(TransactionModel tx) {
    return tx.type == 'receiving' ||
        tx.type == 'received' ||
        tx.type == 'Received';
  }

  bool _isSending(TransactionModel tx) {
    return tx.type == 'send' ||
        tx.type == 'sending' ||
        tx.type == 'Sending' ||
        tx.type == 'Send';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, txProvider, child) {
        if (txProvider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Sum of all "receiving" or "received" transactions (earnings)
        final double totalEarnings = txProvider.transactions
            .where(_isReceiving)
            .fold(0.0, (sum, tx) => sum + tx.amount);

        // Sum of all "send" or "sending" transactions (payouts)
        final double totalPayouts = txProvider.transactions
            .where(_isSending)
            .fold(0.0, (sum, tx) => sum + tx.amount);

        // List of "send" or "sending" transactions (to show under "Payout History")
        final List<TransactionModel> payouts = txProvider.transactions
            .where(_isSending)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'My Earnings & Payout',
              style: TextStyle(
                fontSize: 20,
                color: kDarkPurpleColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: kWhiteColor,
            elevation: 1,
            iconTheme: const IconThemeData(color: kDarkPurpleColor),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─────────── Total Earnings & Total Payouts ───────────
                Text(
                  'Total Earnings:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kDarkPurpleColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'GHC ${totalEarnings.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Total Payouts:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kDarkPurpleColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'GHC ${totalPayouts.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent.shade700,
                  ),
                ),
                const SizedBox(height: 24),

                // ─────────── Payout History ───────────
                Text(
                  'Payout History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kDarkPurpleColor,
                  ),
                ),
                const SizedBox(height: 12),

                // If no payouts, show a placeholder
                if (payouts.isEmpty)
                  const Center(
                    child: Text(
                      'No payouts yet.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      itemCount: payouts.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 24),
                      itemBuilder: (context, index) {
                        final tx = payouts[index];
                        return ListTile(
                          leading: Icon(
                            PhosphorIconsRegular.caretDoubleUp,
                            color: Colors.redAccent.shade700,
                          ),
                          title: Text(
                            tx.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            tx.dateTime,
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: Text(
                            '-GHC ${tx.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent.shade700,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
