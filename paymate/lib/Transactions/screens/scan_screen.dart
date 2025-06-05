// lib/Transactions/screens/scan_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_camera_qrcode_scanner/dynamsoft_barcode.dart';
import 'package:flutter_camera_qrcode_scanner/flutter_camera_qrcode_scanner.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// These imports let us add a new transaction to the provider:
import 'package:provider/provider.dart';
import 'package:paymate/Models/transaction_history_model.dart';

import '../../Widgets/general_btn_widget.dart';
import '../../bottom_nav.dart';
import '../providers_transaction.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  ScannerViewController? controller;
  String _barcodeResults = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Stack(
        children: <Widget>[
          ScannerView(onScannerViewCreated: onScannerViewCreated),

          // Show scanning results + Start/Stop buttons at bottom
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Display barcode results (if any)
              Container(
                height: 100,
                color: Colors.black54,
                child: SingleChildScrollView(
                  child: Text(
                    _barcodeResults,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),

              // Start / Stop buttons
              Container(
                height: 100,
                color: Colors.black54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () async {
                        await controller?.startScanning();
                      },
                      child: GBtnWidget(
                        text: 'Start Scan',
                        width: 100,
                        color: Colors.greenAccent.shade100,
                        height: 40,
                        txtColor: Colors.green.shade900,
                        fontSize: 14,
                        fontWight: FontWeight.normal,
                        bRadius: 12,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () async {
                        await controller?.stopScanning();
                      },
                      child: GBtnWidget(
                        text: 'Stop Scan',
                        width: 100,
                        color: Colors.redAccent.shade100,
                        height: 40,
                        txtColor: Colors.red.shade900,
                        fontSize: 14,
                        fontWight: FontWeight.normal,
                        bRadius: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onScannerViewCreated(ScannerViewController controller) async {
    setState(() {
      this.controller = controller;
    });

    // Initialize the Dynamsoft license (replace with your own key)
    await controller.setLicense(
        'DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTE2NDk4Mjk3OTI2MzUiLCJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSIsInNlc3Npb25QYXNzd29yZCI6IndTcGR6Vm05WDJrcEQ5YUoifQ==');
    await controller.init();
    await controller.startScanning(); // auto‐start on load

    controller.scannedDataStream.listen((results) {
      // Update the on‐screen text with the raw results:
      setState(() {
        _barcodeResults = getBarcodeResults(results);
        print('RAW SCAN: $_barcodeResults');
      });

      // Only proceed if exactly one QR code is detected:
      if (results.length == 1) {
        final String scannedText = results.first.text;

        try {
          // Try parsing as a URI
          final Uri uri = Uri.parse(scannedText);

          // If it’s a UPI pay link (upi://pay?...), extract parameters
          if (uri.scheme == 'upi' && uri.host == 'pay') {
            final Map<String, String> params = uri.queryParameters;

            if (params.containsKey('pn') &&
                params.containsKey('am') &&
                params.containsKey('cu') &&
                params.containsKey('tn')) {
              // Stop scanning immediately
              controller.stopScanning();

              // Show popup and pass the extracted data
              showSuccessPopup(
                context,
                payeeName: params['pn']!,
                amount: params['am']!,
                currency: params['cu']!,
                note: params['tn']!,
              );
            }
          }
        } catch (e) {
          // If parsing fails, ignore or handle error
        }
      }
    });
  }

  String getBarcodeResults(List<BarcodeResult> results) {
    final sb = StringBuffer();
    for (final result in results) {
      sb.writeln(result.format);
      sb.writeln(result.text);
      sb.writeln();
    }
    if (results.isEmpty) {
      sb.write("No QR Code Detected");
    }
    return sb.toString();
  }

  /// Show a dialog on successful UPI parse, then add a new transaction.
  void showSuccessPopup(
    BuildContext parentContext, {
    required String payeeName,
    required String amount,
    required String currency,
    required String note,
  }) {
    showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 30),
              SizedBox(width: 10),
              Text('Scan Successful', style: TextStyle(fontSize: 20)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Payee Name:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(payeeName, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),

              const Text('Amount:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$amount $currency', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),

              const Text('Transaction Note:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(note, style: const TextStyle(fontSize: 16)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // 1) Build a new TransactionModel
                final double parsedAmount = double.tryParse(amount) ?? 0.0;
                final String nowIso = DateTime.now().toIso8601String();

                final newTransaction = TransactionModel(
                  name: payeeName,
                  dateTime: nowIso,
                  amount: parsedAmount,
                  // Choose whichever icon you like; here we assume a “sending” icon:
                  // icon: PhosphorIconsRegular.caretDoubleUp,
                  icon: PhosphorIconsRegular.caretDoubleUp,
                  type: 'Received', // or 'Sending' based on your logic
                );

                // 2) Add it to the provider so it’s persisted and HomeScreen updates
                Provider.of<TransactionProvider>(parentContext, listen: false)
                    .addTransaction(newTransaction);

                // 3) Close the dialog and pop back to whatever screen you want
                Navigator.of(dialogContext).pop(); // close AlertDialog
                Navigator.of(parentContext).pop(); // close ScanScreen itself
                Navigator.of(parentContext).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const BottomNav()),
                    (Route<dynamic> route) => false);
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
