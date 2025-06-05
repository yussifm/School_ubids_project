// lib/Home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:paymate/Transactions/providers_transaction.dart';
import 'package:provider/provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:paymate/Transactions/widgets/add_card_btn_widgets.dart';
import 'package:paymate/Home/Widgets/credit_card_widget.dart';
import 'package:paymate/Home/Widgets/mobile_payment_widget.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';

import '../../Models/credit_card_data_model.dart';
import '../../Models/mobile_pay_model.dart';
import '../../Profile/user_provider.dart';
import '../Widgets/transactional_history_widget.dart';

// Import your TransactionProvider (which persists via SharedPreferences)

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isCardView = true;
// Default username until loaded from SharedPreferences

  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // Obtain the provider; whenever TransactionProvider.notifyListeners() is called,
    // this widget rebuilds and the ListView below will update automatically.
    final txProvider = Provider.of<TransactionProvider>(context);
    var listOftrans = txProvider.transactions.reversed.toList();
    final userProv = Provider.of<UserProvider>(context);
    final userName = userProv.userName;

   



    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // ───────────── Header Row ─────────────
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'HI, ${userName.toUpperCase()}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: kDarkPurpleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    radius: 50,
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      setState(() {
                        isCardView = !isCardView;
                      });
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
                  ),
                ],
              ),
            ),
            // ───────────── Balance Section ─────────────
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Balance',
                    style: TextStyle(
                      fontSize: 16,
                      color: kDarkPurpleColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '\$${txProvider.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: kDarkPurpleColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // ───────────── Section Title ─────────────
            Padding(
              padding: const EdgeInsets.only(left: 18, bottom: 5),
              child: Text(
                isCardView ? 'Cards Payment' : 'Mobile Payments',
                style: const TextStyle(
                  fontSize: 18,
                  color: kDarkPurpleColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // ───────────── Cards / Mobile View ─────────────
            SizedBox(
              height: 200, // adjust this height as needed for your card row
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isCardView)
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
                      )
                    else
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
                    AddCardBtnWidgets(deviceSize: deviceSize),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ───────────── Transaction History Title ─────────────
            const Padding(
              padding: EdgeInsets.only(left: 18, right: 20),
              child: Text(
                'Transaction History',
                style: TextStyle(
                  fontSize: 18,
                  color: kDarkPurpleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ───────────── Transaction List ─────────────
            // We wrap ListView in Expanded so it takes up the remaining space.
            Expanded(
              child: txProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : txProvider.transactions.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'No transactions yet. Perform a transaction to see history.',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: listOftrans.length,
                          itemBuilder: (ctx, index) {
                            final tx = listOftrans[index];
                            return Dismissible(
                              key: ValueKey(
                                  tx.dateTime + tx.name + tx.amount.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              onDismissed: (_) {
                                // Remove from provider (this also updates SharedPreferences)
                                txProvider.removeTransactionAt(index);
                              },
                              child: TransactionHistoryWidget(
                                transaction: tx,
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
