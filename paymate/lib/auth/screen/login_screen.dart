import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';
import 'package:paymate/auth/screen/register_screen.dart';
import 'package:paymate/bottom_nav.dart';
import 'package:paymate/helpers/loader.dart';
import 'package:paymate/helpers/validater.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'forgot_password_scrren.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController numberController =
      TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  var _initialCountryCode = 'GH';

  bool _isHidden = true;
  bool _isLoading = false;

  void _togglePasswordView() {
    if (!mounted) return;
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      kPrimaryColor, // Replace with the closest matching colors
                      kDarkPurpleColor,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.12),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          kPrimaryColor, // Replace with the closest matching colors
                          kDarkPurpleColor,
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Expanded(child: Container()),
                        const Text(
                          'Welcome Back',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: kWhiteColor,
                            height: 1.28,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Text(
                            'PayMate makes payment fast and simple',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 1.17,
                              color: kWhiteColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.35),
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(25),
                    right: Radius.circular(25),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: double.infinity,
                    color: kWhiteColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: kDarkPurpleColor,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        ///Mobile number input
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              'Phone Number',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: textFieldLabelTextColor,
                                height: 1.17,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15.0, bottom: 20),
                          child: IntlPhoneField(
                            disableLengthCheck: true,
                            dropdownIconPosition: IconPosition.trailing,
                            showCountryFlag: true,
                            autovalidateMode: AutovalidateMode.disabled,
                            style: const TextStyle(
                                color: kSecondaryGreyTextColor,
                                fontStyle: FontStyle.italic,
                                fontSize: 17),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(
                                18.0,
                              ),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: textFieldBorderColor, width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: textFieldBorderColor, width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              counter: const SizedBox(),
                              fillColor: colorGrey4,
                              focusColor: focustextFieldColor,
                              hintText: 'Enter Phone Number',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: textFieldLabelTextColor,
                              ),
                            ),
                            initialCountryCode: _initialCountryCode,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            flagsButtonPadding:
                                const EdgeInsets.only(left: 20, right: 10),
                            dropdownIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.transparent,
                            ),
                            showDropdownIcon: false,
                            flagsButtonMargin: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            dropdownDecoration: BoxDecoration(
                                color: colorInputFieldLightBlueBackground,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            dropdownTextStyle: const TextStyle(
                                color: kSecondaryGreyTextColor,
                                fontStyle: FontStyle.italic,
                                fontSize: 14),
                            onChanged: (phone) {
                              numberController.text = phone.completeNumber;
                            },
                            onCountryChanged: ((country) async {
                              setState(() {
                                _initialCountryCode = country.code;
                              });
                            }),
                          ),
                        ),

                        ///Password Input
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: textFieldLabelTextColor,
                                height: 1.17,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            obscureText: _isHidden,
                            controller: passwordController,
                            validator: (val) => Validator.commonValidator(
                                val: val,
                                errorMessage: 'Password can\'t be empty',
                                characterLimit: 8,
                                errorMessageForCharacter:
                                    'Password can\'t be less than 8 characters'),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(
                                20.0,
                              ),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.transparent, width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: textFieldBorderColor, width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: textFieldBorderColor, width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              fillColor: colorGrey4,
                              focusColor: focustextFieldColor,
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: textFieldLabelTextColor,
                                height: 1.17,
                              ),
                              suffixIcon: Container(
                                decoration: BoxDecoration(
                                  // color: colorBlue4,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 20.0,
                                width: 20.0,
                                margin: const EdgeInsets.only(
                                    right: 5.0,
                                    top: 5.0,
                                    bottom: 5.0,
                                    left: 5.0),
                                child: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Icon(
                                    _isHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: kDarkPurpleColor,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        RichText(
                          text: TextSpan(
                            text: '',
                            children: [
                              TextSpan(
                                text: 'Forgot Password',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: kPrimaryColor,
                                  height: 1.17,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPasswordScreen()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 100,
                        ),

                        _isLoading
                            ? Expanded(
                                child: showLoader(),
                              )
                            : InkWell(
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  // if (_formKey.currentState!.validate()) {

                                  //  // TODO: Add login functionality
                                  // }
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BottomNav()),
                                      (Route<dynamic> route) => false);
                                 
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          kPrimaryColor, // Replace with the closest matching colors
                                          kDarkPurpleColor,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Login',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: kWhiteColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_outlined,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                            text: '',
                            children: [
                              TextSpan(
                                text: '''Don't have an account?''',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: textFieldLabelTextColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegistrationScreen()),
                                    );
                                  },
                              ),
                              TextSpan(
                                text: ' Create here',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: kDarkPurpleColor,
                                  height: 1.17,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegistrationScreen()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
