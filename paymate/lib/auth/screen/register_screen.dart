import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paymate/Widgets/common_input.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';
import 'package:paymate/auth/screen/login_screen.dart';
import 'package:paymate/bottom_nav.dart';
import 'package:paymate/helpers/loader.dart';
import 'package:paymate/helpers/validater.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../helpers/toast_.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isHidden = true;
  bool _isConfirmPasswordHidden = true;
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController confirmPasswordController =
      TextEditingController(text: '');
  final TextEditingController numberController =
      TextEditingController(text: '');

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  bool agree = false;

  var _initialCountryCode = 'GH';

  void _togglePasswordView() {
    if (!mounted) return;
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _toggleConfirmPasswordView() {
    if (!mounted) return;
    setState(() {
      _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
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
                          'Hi Welcome',
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Sign Up',
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
                      
                          ///Full Name Input
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text(
                                'Full Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: textFieldLabelTextColor,
                                  height: 1.17,
                                ),
                              ),
                            ),
                          ),
                          commonTextField(
                            context: context,
                            controller: nameController,
                            hintText: '',
                            keyBoardType: TextInputType.name,
                            validator: (val) => Validator.commonValidator(
                                val: val!,
                                errorMessage: 'Name can\'t be empty',
                                errorMessageForCharacter: 'Name can\'t be empty'),
                          ),
                      
                          const SizedBox(
                            height: 20,
                          ),
                      
                          ///Email Input
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text(
                                'Email ID',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: textFieldLabelTextColor,
                                  height: 1.17,
                                ),
                              ),
                            ),
                          ),
                          commonTextField(
                            context: context,
                            controller: emailController,
                            hintText: '',
                            keyBoardType: TextInputType.emailAddress,
                            validator: (val) => Validator.validateEmail(
                              val: val!,
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
                                horizontal: 10, vertical: 10),
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
                                  10.0,
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
                      
                          const SizedBox(
                            height: 20,
                          ),
                      
                          ///Confirm Password Input
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Text(
                                'Confirm Password',
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
                                horizontal: 10, vertical: 10),
                            child: TextFormField(
                              obscureText: _isConfirmPasswordHidden,
                              controller: confirmPasswordController,
                              validator: (val) =>
                                  Validator.validateConfirmPassword(
                                      password: passwordController.text,
                                      confirmPassword:
                                          confirmPasswordController.text),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(
                                  10.0,
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
                                hintText: '',
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
                                    onTap: _toggleConfirmPasswordView,
                                    child: Icon(
                                      _isConfirmPasswordHidden
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
                                    //   if (agree) {
                                    //   } else {
                                    //     showToast(
                                    //         msg:
                                    //             'Please agree to the terms and conditions');
                                    //   }
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
                                            'Register',
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
                            height: 20,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: '',
                                children: [
                                  TextSpan(
                                    text: '''Already have an account?''',
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
                                                  const LoginScreen()),
                                        );
                                      },
                                  ),
                                  TextSpan(
                                    text: ' Log In',
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
                                                  const LoginScreen()),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
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
