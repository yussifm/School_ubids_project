// lib/Profile/screens/faq_support_screen.dart

import 'package:flutter/material.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';

class FAQSupportScreen extends StatelessWidget {
  const FAQSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example FAQ items
    final faqs = [
      {
        'question': 'How do I reset my password?',
        'answer':
            'To reset your password, go to Settings > Account > Reset Password and follow the instructions.'
      },
      {
        'question': 'How can I contact support?',
        'answer':
            'You can reach out to our support team at support@paymate.com or call +233 123 456 789.'
      },
      {
        'question': 'Where can I view my transaction history?',
        'answer':
            'Transaction history is available under Home > Transaction History. All your payments will be listed there.'
      },
      // Add more FAQ items as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FAQ's & Support",
          style: TextStyle(
            fontSize: 20,
            color: kDarkPurpleColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
        iconTheme: const IconThemeData(color: kDarkPurpleColor),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        separatorBuilder: (context, index) => const Divider(height: 32),
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return ExpansionTile(
            title: Text(
              faq['question']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  faq['answer']!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 160,
        ),
        child: ElevatedButton.icon(
          icon: const Icon(
            Icons.chat_bubble_outline,
            color: Colors.white,
          ),
          label: const Text(
            'Contact Support',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            // Navigate to a chat screen or open email intent
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Contact Support'),
                content: const Text(
                  'You can email us at support@paymate.com or call +233 123 456 789.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
