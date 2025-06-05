// lib/main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paymate/Profile/user_provider.dart';
import 'package:paymate/Transactions/providers_transaction.dart';
import 'package:paymate/firebase_options.dart';
import 'package:paymate/onboarding/screens/main_onboading_screen.dart';
import 'package:provider/provider.dart';
import 'package:paymate/onboarding/onboarding_provider.dart';

import 'bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProv, child) {
        // While onboarding state is loading, show a spinner
        if (onboardingProv.isLoading) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        // Once loaded, decide: if seen==true, go to BottomNav; else OnboardingScreen
        return MaterialApp(
          title: 'PayMate',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: "Rubik",
          ),
          home: onboardingProv.seen
              ? const BottomNav()
              : const OnboardingScreen(),
        );
      },
    );
  }
}
