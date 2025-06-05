import 'package:flutter/material.dart';
import 'package:paymate/bottom_nav.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

import 'package:paymate/apptheme/colors/colors_app.dart';

import '../../Models/transaction_history_model.dart';
import '../providers_transaction.dart';

class QRCodeGenScreen extends StatefulWidget {
  final String upID;
  final String payeeName;
  final double amount;
  final String transactionNote;
  final String currency;
  const QRCodeGenScreen({
    Key? key,
    required this.upID,
    required this.payeeName,
    required this.amount,
    required this.transactionNote,
    required this.currency,
  }) : super(key: key);

  @override
  State<QRCodeGenScreen> createState() => _QRCodeGenScreenState();
}

class _QRCodeGenScreenState extends State<QRCodeGenScreen> {
  UPIDetails upiDetails = UPIDetails(
    upiID: "",
    payeeName: "",
    amount: 0,
    currencyCode: "GHC",
    transactionNote: "",
  );

  bool isLoading = false;

  @override
  void initState() {
    upiDetails = UPIDetails(
      upiID: widget.upID,
      payeeName: widget.payeeName,
      amount: widget.amount,
      currencyCode: widget.currency,
      transactionNote: widget.transactionNote,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment QRCode',
          style: TextStyle(
            fontSize: 18,
            color: kDarkPurpleColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
           
            final String nowIso = DateTime.now().toIso8601String();

            final newTransaction = TransactionModel(
              name: upiDetails.payeeName,
              dateTime: nowIso,
              amount: upiDetails.amount ?? 0.0,
              // Choose whichever icon you like; here we assume a “sending” icon:
              icon: PhosphorIconsRegular.caretDoubleUp,
              type: 'send', // or 'Sending' based on your logic
            );

            await Provider.of<TransactionProvider>(context, listen: false)
                .addTransaction(newTransaction);
            setState(() {
              isLoading = false;
            });

            if (isLoading == false) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const BottomNav()),
                  (Route<dynamic> route) => false);
            }
            
          },
        ),
      ),
      body: Center(
        child: Visibility(
          visible: !isLoading,
          replacement: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text("Checking Payment status..."),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Scan QR to Pay",
                style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
              ),
              const SizedBox(
                height: 20,
              ),
              UPIPaymentQRCode(
                upiDetails: upiDetails,
                size: 220,
                upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.high,
              ),
              Text(
                "Scan QR to Pay",
                style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
