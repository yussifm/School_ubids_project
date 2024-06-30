
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

import 'package:paymate/apptheme/colors/colors_app.dart';
import 'package:paymate/auth/screen/login_screen.dart';

import '../../auth/screen/register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Register',
      onFinish: () {
        // Navigate to Register screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegistrationScreen(),
          ),
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
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
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
      trailingFunction: () {
        // Navigate to login screen
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ));
      },
      background: [
        Image.asset(
          'assets/images/Hello-rafiki.png',
          height: 400,
          fit: BoxFit.fitWidth,
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
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Welcome to PayMate',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkPurpleColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'less, secure, and convenient contactless payments. PayMate empowers you to handle transactions with just a tap or scan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Quick and Easy Payments',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkPurpleColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Use QR codes, NFC, and other advanced technologies to pay effortlessly. Whether you're buying a coffee or shopping for groceries, PayMate makes it fast and simple.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Secure Transactions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkPurpleColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Your security is our priority. With robust encryption and secure protocols, PayMate ensures your payments are safe and protected.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text(
                'Get Started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kDarkPurpleColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Ready to transform your payment experience? Sign up or log in to start using PayMate today!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
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
