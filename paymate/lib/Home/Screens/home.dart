import 'package:flutter/material.dart';
import 'package:paymate/Home/Widgets/credit_card_widget.dart';
import 'package:paymate/Home/Widgets/mobile_payment_widget.dart';
import 'package:paymate/Home/Widgets/transactional_history_widget.dart';
import 'package:paymate/Models/credit_card_data_model.dart';
import 'package:paymate/Models/mobile_pay_model.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../Models/transaction_history_model.dart';
import '../../apptheme/colors/colors_app.dart';


final List<TransactionModel> transactions = [
  TransactionModel(
    name: 'Grocery Store',
    dateTime: '12:22 a.m May 20',
    amount: 350.0,
    icon: PhosphorIconsRegular.caretDoubleUp,
    type: 'sending',
  ),
  TransactionModel(
    name: 'Coffee Shop',
    dateTime: '10:15 a.m May 18',
    amount: 50.0,
    icon: PhosphorIconsRegular.caretDoubleDown,
    type: 'receiving',
  ),
  TransactionModel(
    name: 'Grocery Store',
    dateTime: '12:22 a.m May 20',
    amount: 350.0,
    icon: PhosphorIconsRegular.caretDoubleUp,
    type: 'sending',
  ),
  TransactionModel(
    name: 'Coffee Shop',
    dateTime: '10:15 a.m May 18',
    amount: 50.0,
    icon: PhosphorIconsRegular.caretDoubleDown,
    type: 'receiving',
  ),
  TransactionModel(
    name: 'Grocery Store',
    dateTime: '12:22 a.m May 20',
    amount: 350.0,
    icon: PhosphorIconsRegular.caretDoubleUp,
    type: 'sending',
  ),
  TransactionModel(
    name: 'Coffee Shop',
    dateTime: '10:15 a.m May 18',
    amount: 50.0,
    icon: PhosphorIconsRegular.caretDoubleDown,
    type: 'receiving',
  ),
  TransactionModel(
    name: 'Grocery Store',
    dateTime: '12:22 a.m May 20',
    amount: 350.0,
    icon: PhosphorIconsRegular.caretDoubleUp,
    type: 'sending',
  ),
  TransactionModel(
    name: 'Coffee Shop',
    dateTime: '10:15 a.m May 18',
    amount: 50.0,
    icon: PhosphorIconsRegular.caretDoubleDown,
    type: 'receiving',
  ),
];


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isCardView = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'HI, Coded',
                    style: TextStyle(
                      fontSize: 18,
                      color: kDarkPurpleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    radius: 50,
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      isCardView = !isCardView;
                      setState(() {});
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isCardView ? kOrangeColor : kDarkPurpleColor,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        isCardView
                            ? PhosphorIconsFill.creditCard
                            : PhosphorIconsFill.deviceMobile,
                        color: isCardView ? kOrangeColor : kDarkPurpleColor,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                left: 18,
                bottom: 5,
              ),
              child: Text(
                isCardView ? 'Cards Payment' : 'Mobile Payments',
                style: const TextStyle(
                  fontSize: 18,
                  color: kDarkPurpleColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            isCardView
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(
                          3,
                          (index) => CreditCardWidget(
                            creditCard: CreditCardModel(
                              cardNumber: '1234 5678 9101 1121',
                              expiryDate: '12/24',
                              cardHolderName: 'John Doe',
                              cvvCode: '123',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(
                          2,
                          (index) => MobilePaymentWidget(
                            mobilePayment: MobilePaymentModel(
                              phoneNumber: '+1234567890',
                              userName: 'Jane Doe',
                              provider: 'MTN',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 18, right: 20),
              child: Text(
                'Transaction History',
                style: TextStyle(
                  fontSize: 18,
                  color: kDarkPurpleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return TransactionHistoryWidget(
                      transaction: transactions[index]);
                },
                itemCount: transactions.length,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


