import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_camera_qrcode_scanner/flutter_camera_qrcode_scanner.dart';
import 'package:flutter_camera_qrcode_scanner/dynamsoft_barcode.dart';

import '../../Widgets/general_btn_widget.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

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
      body: Stack(children: <Widget>[
        ScannerView(onScannerViewCreated: onScannerViewCreated),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 100,
              child: SingleChildScrollView(
                child: Text(
                  _barcodeResults,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () async {
                        controller!.startScanning();
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
                        controller!.stopScanning();
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
                  ]),
            ),
          ],
        )
      ]),
    );
  }

  void onScannerViewCreated(ScannerViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    await controller.setLicense(
        'DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTE2NDk4Mjk3OTI2MzUiLCJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSIsInNlc3Npb25QYXNzd29yZCI6IndTcGR6Vm05WDJrcEQ5YUoifQ==');
    await controller.init();
    await controller.startScanning(); // auto start scanning
    controller.scannedDataStream.listen((results) {
      setState(() {
        _barcodeResults = getBarcodeResults(results);
        print(_barcodeResults);
        //  upi://pay?pa=+1234567890&pn=Agnel Selvan&tr=&am=1.0&cu=GHC&mc=0000&mode=02&purpose=00&tn=Hello World&tr=
      });
      // Process only if there's exactly one QR code detected
      if (results.length == 1) {
        String scannedText = results.first.text;
        try {
          // Parse the scanned text as a URI
          Uri uri = Uri.parse(scannedText);

          // Check if it's a UPI payment link
          if (uri.scheme == 'upi' && uri.host == 'pay') {
            Map<String, String> params = uri.queryParameters;

            // Validate that required parameters are present
            if (params.containsKey('pn') &&
                params.containsKey('am') &&
                params.containsKey('cu') &&
                params.containsKey('tn')) {
              // Stop the scanner
              controller.stopScanning();

              // Show the success popup with extracted details
              showSuccessPopup(context, params['pn']!, params['am']!,
                  params['cu']!, params['tn']!);
            }
          }
        } catch (e) {
          // If parsing fails (e.g., invalid URI), do nothing or handle the error as needed
        }
      }
    });
  }

  String getBarcodeResults(List<BarcodeResult> results) {
    StringBuffer sb = new StringBuffer();
    for (BarcodeResult result in results) {
      sb.write(result.format);
      sb.write("\n");
      sb.write(result.text);
      sb.write("\n\n");
    }
    if (results.isEmpty) sb.write("No QR Code Detected");
    return sb.toString();
  }

  void showSuccessPopup(
      BuildContext context, String pn, String am, String cu, String tn) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
              Text(pn, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              const Text('Amount:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$am $cu', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              const Text('Transaction Note:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(tn, style: const TextStyle(fontSize: 16)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller?.stopScanning();
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the screen
              },
              child: const Text('Close',
                  style: TextStyle(
                    color: Colors.blue,
                  )),
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
