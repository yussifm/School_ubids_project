// credit_card_widget.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paymate/Models/credit_card_data_model.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';

List<Color> colorPalette = [
  kPrimaryColor,
  Colors.pinkAccent,
  kOrangeColor,
  kDarkPurpleColor,
];

Color getRandomPaletteColor() {
  Random random = Random();
  return colorPalette[random.nextInt(colorPalette.length)];
}

class CreditCardWidget extends StatelessWidget {
  final CreditCardModel creditCard;

  const CreditCardWidget({super.key, required this.creditCard});

  @override
  Widget build(BuildContext context) {
    Color startColor = getRandomPaletteColor();
    Color endColor = getRandomPaletteColor();

    // Ensure the two colors are different
    while (endColor == startColor) {
      endColor = getRandomPaletteColor();
    }

    Size deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: deviceSize.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage(
              "assets/images/gray_line_drawings_of_organic_shapes_background.jpg"),
          fit: BoxFit.fill,
          opacity: 0.4,
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.modulate,
          ),
        ),
        color: startColor,
        boxShadow: [
          BoxShadow(
            color: startColor.withOpacity(0.2),
            blurRadius: 2,
            spreadRadius: 3,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Card Number',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  creditCard.cardNumber,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Expiry Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          creditCard.expiryDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CVV',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          creditCard.cvvCode,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Card Holder Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  creditCard.cardHolderName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
