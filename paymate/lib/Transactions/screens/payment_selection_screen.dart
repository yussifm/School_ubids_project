import 'package:flutter/material.dart';
import 'package:paymate/Home/Widgets/credit_card_widget.dart';
import 'package:paymate/Home/Widgets/mobile_payment_widget.dart';
import 'package:paymate/Models/credit_card_data_model.dart';
import 'package:paymate/Transactions/widgets/add_card_btn_widgets.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../Models/mobile_pay_model.dart';

class PaymentSelectorScreen extends StatefulWidget {
  bool isCardView;
  bool isQrCode;
  PaymentSelectorScreen({
    Key? key,
    required this.isCardView,
    required this.isQrCode,
  }) : super(key: key);

  @override
  State<PaymentSelectorScreen> createState() => _PaymentSelectorScreenState();
}

class _PaymentSelectorScreenState extends State<PaymentSelectorScreen> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: widget.isCardView
              ? const Text(
                  "Select Card to be used",
                  style: TextStyle(
                    fontSize: 18,
                    color: kDarkPurpleColor,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : const Text(
                  "Select Number to be used",
                  style: TextStyle(
                    fontSize: 18,
                    color: kDarkPurpleColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.isCardView)
                ...List.generate(4, (indexCard) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                      top: 10,
                    ),
                    child: CreditCardWidget(
                      creditCard: CreditCardModel(
                        cardNumber: '1234 5678 9101 1121',
                        expiryDate: '12/24',
                        cardHolderName: 'John Doe',
                        cvvCode: '123',
                      ),
                    ),
                  );
                }),
              if (!widget.isCardView)
                ...List.generate(4, (indexCard) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                      top: 10,
                    ),
                    child: MobilePaymentWidget(
                      mobilePayment: MobilePaymentModel(
                        phoneNumber: '+1234567890',
                        userName: 'Jane Doe',
                        provider: 'MTN',
                      ),
                    ),
                  );
                }),
              AddCardBtnWidgets(deviceSize: deviceSize),
            ],
          ),
        ),
      ),
    );
  }
}
