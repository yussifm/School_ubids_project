import 'package:flutter/material.dart';
import 'package:paymate/Home/Widgets/credit_card_widget.dart';
import 'package:paymate/Home/Widgets/mobile_payment_widget.dart';
import 'package:paymate/Models/credit_card_data_model.dart';
import 'package:paymate/Transactions/screens/payment_screen.dart';
import 'package:paymate/Transactions/widgets/add_card_btn_widgets.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
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
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: deviceSize.width,
           
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.isCardView)
                  ...List.generate(4, (indexCard) {
                    CreditCardModel creditCard = CreditCardModel(
                      cardNumber: '1234 5678 9101 1112$indexCard',
                      expiryDate: '12/2$indexCard',
                      cardHolderName: 'John Doe',
                      cvvCode: '12$indexCard',
                    );
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                        top: 10,
                      ),
                      child: InkWell(
                        onTap: () {
                          pushScreenWithoutNavBar(
                              context,
                              PaymentScreen(
                                isCardView: widget.isCardView,
                                isQrCode: widget.isQrCode,
                                creditCardDetails: creditCard,
                              ));
                        },
                        child: CreditCardWidget(
                          creditCard: creditCard,
                        ),
                      ),
                    );
                  }),
                if (!widget.isCardView)
                  ...List.generate(4, (indexP) {
                    MobilePaymentModel mobilePayment = MobilePaymentModel(
                      phoneNumber: '+123456789$indexP',
                      userName: 'Jane Doe$indexP',
                      provider: 'MTN',
                    );
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                        top: 10,
                      ),
                      child: InkWell(
                        onTap: () {
                          pushScreenWithoutNavBar(
                              context,
                              PaymentScreen(
                                isCardView: widget.isCardView,
                                isQrCode: widget.isQrCode,
                                phonePaymentDetails: mobilePayment,
                              ));
                        },
                        child: MobilePaymentWidget(
                          mobilePayment: mobilePayment,
                        ),
                      ),
                    );
                  }),
                AddCardBtnWidgets(deviceSize: deviceSize),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
