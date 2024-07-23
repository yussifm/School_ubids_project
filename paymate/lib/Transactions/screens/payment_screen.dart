import 'package:flutter/material.dart';
import 'package:paymate/Models/credit_card_data_model.dart';
import 'package:paymate/Models/mobile_pay_model.dart';
import 'package:paymate/Transactions/screens/qr_code_gen_screen.dart';
import 'package:paymate/Transactions/screens/scan_screen.dart';
import 'package:paymate/Widgets/general_btn_widget.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:flutter/services.dart';
import 'package:flutter_camera_qrcode_scanner/flutter_camera_qrcode_scanner.dart';
import 'package:flutter_camera_qrcode_scanner/dynamsoft_barcode.dart';

import '../../apptheme/colors/colors_app.dart';

class PaymentScreen extends StatefulWidget {
  final bool isCardView;
  final bool isQrCode;
  MobilePaymentModel? phonePaymentDetails;
  CreditCardModel? creditCardDetails;
  PaymentScreen(
      {Key? key,
      required this.isCardView,
      required this.isQrCode,
      this.phonePaymentDetails,
      this.creditCardDetails})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  ScannerViewController? controller;
  String _barcodeResults = '';
  bool showScanView = false;
  TextEditingController _upiIDController = TextEditingController(text: "");
  TextEditingController _payeeNameController =
      TextEditingController(text: 'Agnel Selvan');
  TextEditingController _amountController = TextEditingController(text: '1');
  TextEditingController _currencyCodeController =
      TextEditingController(text: 'GHC');
  TextEditingController _transactionNoteController =
      TextEditingController(text: 'Hello World');

  @override
  void initState() {
    _upiIDController = TextEditingController(
      text: widget.isCardView
          ? widget.creditCardDetails!.cardHolderName.toString()
          : widget.phonePaymentDetails!.phoneNumber.toString(),
    );
    super.initState();
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
      });
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: widget.isQrCode
            ? const Text(
                "QR Code Payment",
                style: TextStyle(
                  fontSize: 18,
                  color: kDarkPurpleColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            : const Text(
                "NFC/RFID Payment",
                style: TextStyle(
                  fontSize: 18,
                  color: kDarkPurpleColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SizedBox(
        width: deviceSize.width,
        height: deviceSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            // ScannerView(onScannerViewCreated: onScannerViewCreated),
            const Text(
              "Select one of the Options below",
              style: TextStyle(
                  color: kDarkPurpleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: () async {
                if (widget.isQrCode) {
                  pushScreenWithoutNavBar(context, const ScanScreen());
                }
              },
              child: GBtnWidget(
                text: 'Receive',
                width: deviceSize.width * 0.5,
                color: Colors.greenAccent.shade100,
                height: 40,
                txtColor: Colors.green.shade900,
                fontSize: 14,
                fontWight: FontWeight.normal,
                bRadius: 12,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: () async {
                if (widget.isQrCode) {
                  _showFormDialog(context);
                  // pushScreenWithoutNavBar(
                  //     context,
                  //     const QRCodeGenScreen(
                  //       upID: '',
                  //       payeeName: '',
                  //       amount: 4,
                  //       transactionNote: '',
                  //       currency: '',
                  //     ));
                }
              },
              child: GBtnWidget(
                text: 'Send',
                width: deviceSize.width * 0.5,
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
    );
  }

  void _showFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Details'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _payeeNameController,
                  decoration: const InputDecoration(labelText: 'Payee Name'),
                ),
                TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _currencyCodeController,
                  decoration: const InputDecoration(labelText: 'Currency Code'),
                ),
                TextField(
                  controller: _transactionNoteController,
                  decoration:
                      const InputDecoration(labelText: 'Transaction Note'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                _submitForm();
              },
            ),
          ],
        );
      },
    );
  }

  void _submitForm() {
    final upiID = _upiIDController.text;
    final payeeName = _payeeNameController.text;
    final amount = double.parse(_amountController.text);
    final currencyCode = _currencyCodeController.text;
    final transactionNote = _transactionNoteController.text;

    Navigator.of(context).pop(); // Close the dialog

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeGenScreen(
          upID: upiID,
          payeeName: payeeName,
          amount: amount,
          transactionNote: transactionNote,
          currency: currencyCode,
        ),
      ),
    );
  }
}
