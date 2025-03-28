import 'package:flutter/material.dart';
import 'package:paymate/Services/local_services.dart';
import 'package:paymate/Transactions/screens/payment_selection_screen.dart';
import 'package:paymate/Transactions/widgets/payment_selector_widgets.dart';

import 'package:paymate/apptheme/colors/colors_app.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool isCardView = true;
  bool isQrCode = true;
  bool isAuth = false;
  bool isLoading = false;
  bool isNfcAvailable = false;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tap & Pay',
          style: TextStyle(
            fontSize: 24,
            color: kDarkPurpleColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Payments Account',
                style: TextStyle(
                  fontSize: 18,
                  color: kDarkPurpleColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isCardView = true;
                      });
                    },
                    child: PaymentSelectorWidget(
                      deviceSize: deviceSize,
                      title: 'Card',
                      imgsrc: 'assets/icons/credit-card.png',
                      isSelected: isCardView,
                      color: Colors.orange,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isCardView = false;
                      });
                    },
                    child: PaymentSelectorWidget(
                      deviceSize: deviceSize,
                      title: 'Mobile Payment',
                      imgsrc: 'assets/icons/mobile-banking.png',
                      isSelected: !isCardView,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Select Payments Method',
                style: TextStyle(
                  fontSize: 18,
                  color: kDarkPurpleColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isQrCode = true;
                      });
                    },
                    child: PaymentSelectorWidget(
                      deviceSize: deviceSize,
                      title: 'QR COde',
                      imgsrc: 'assets/icons/qr-code (1).png',
                      isSelected: isQrCode,
                      color: Colors.blueAccent,
                    ),
                  ),
                  InkWell(
                    onTap: isNfcAvailable
                        ? () {
                            setState(() {
                              isQrCode = false;
                            });
                          }
                        : () {
                            showDisabledPopup(context);
                          },
                    splashColor: isNfcAvailable ? null : Colors.transparent,
                    highlightColor: isNfcAvailable ? null : Colors.transparent,
                    child: PaymentSelectorWidget(
                      deviceSize: deviceSize,
                      title: 'NFC/RFID',
                      imgsrc: 'assets/icons/nfc_.png',
                      isSelected: !isQrCode,
                      color: isNfcAvailable ? Colors.greenAccent : Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Center(
                child: Visibility(
                  visible: !isLoading,
                  replacement: const CircularProgressIndicator(),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(40),
                    onTap: () async {
                      // await checkBiometric();
                      // remember to change this back
                      if (!isAuth) {
                        pushScreenWithoutNavBar(
                            context,
                            PaymentSelectorScreen(
                              isCardView: isCardView,
                              isQrCode: isQrCode,
                            ));
                      }
                    },
                    child: Container(
                      width: 180,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: kDarkPurpleColor,
                      ),
                      child: const Text(
                        "Unlock Transaction",
                        style: TextStyle(
                          fontSize: 14,
                          color: kWhiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: deviceSize.height < 800 ? 130 : 40),
            ],
          ),
        ),
      ),
    );
  }

  checkBiometric() async {
    // check for biometric availability
    print("Trans tap");
    setState(() {
      isLoading = true;
    });
    isAuth = await LocalAuthService.authenticate();
    setState(() {
      isLoading = false;
    });
  }

  void showDisabledPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('NFC/RFID Unavailable'),
          content: const Text(
              'NFC/RFID functionality is currently disabled or not supported on this device.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
