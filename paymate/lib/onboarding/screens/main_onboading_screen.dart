// lib/onboarding/screens/main_onboading_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:provider/provider.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';
import 'package:paymate/auth/screen/login_screen.dart';
import 'package:paymate/onboarding/onboarding_provider.dart';

import '../../bottom_nav.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return OnBoardingSlider(
      finishButtonText: 'Get Started',
      onFinish: () async {
        // 1) Mark onboarding as seen
        await Provider.of<OnboardingProvider>(context, listen: false)
            .markSeen();

        // 2) Navigate to BottomNav, removing all previous routes
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const BottomNav()),
          (Route<dynamic> route) => false,
        );
      },
      totalPage: 4,
      headerBackgroundColor: kWhiteColor,
      controllerColor: kDarkPurpleColor,
      pageBackgroundColor: kWhiteColor,
      speed: 1,
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: kDarkPurpleColor,
        elevation: 2.2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
      ),
      skipTextButton: const Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: kDarkPurpleColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Text(
        'Login',
        style: TextStyle(
          fontSize: 16,
          color: kDarkPurpleColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () async {
        // 1) Mark onboarding as seen (so we don't show it again)
        await Provider.of<OnboardingProvider>(context, listen: false)
            .markSeen();

        // 2) Navigate to Login screen (or straight to BottomNav if you prefer)
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (Route<dynamic> route) => false,
        );
      },
      background: [
        Center(
          child: Image.asset(
            'assets/images/Hello-rafiki.png',
            height: 400,
            fit: BoxFit.fitWidth,
          ),
        ),
        Image.asset(
          'assets/images/Scantopay.gif',
          height: 400,
          color: kOrangeColor,
          colorBlendMode: BlendMode.color,
        ),
        Image.asset(
          'assets/images/Onlinetransactions.gif',
          height: 400,
        ),
        Image.asset(
          'assets/images/CreditCardPaymento.gif',
          height: 400,
          color: kPrimaryColor,
          colorBlendMode: BlendMode.color,
        ),
      ],
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: deviceSize.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(height: deviceSize.height < 800 ? 390 : 480),
              const Text(
                'Welcome to PayMate',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkPurpleColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Secure, convenient contactless payments. PayMate empowers you with just a tap or scan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: deviceSize.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(height: deviceSize.height < 800 ? 390 : 480),
              const Text(
                'Quick & Easy Payments',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkPurpleColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                "Use QR codes, NFC, and more. PayMate makes every purchase fast and simple.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: deviceSize.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(height: deviceSize.height < 800 ? 390 : 480),
              const Text(
                'Secure Transactions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkPurpleColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Your security is our priority. PayMate uses strong encryption and protocols to keep you safe.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: deviceSize.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(height: deviceSize.height < 800 ? 390 : 480),
              const Text(
                'Get Started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkPurpleColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Ready to transform your experience? Sign up or log in now!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
