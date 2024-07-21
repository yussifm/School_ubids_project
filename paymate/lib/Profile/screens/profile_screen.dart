import 'package:flutter/material.dart';
import 'package:paymate/Profile/widgets/profile_btn_widget.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';
import 'package:paymate/onboarding/screens/main_onboading_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            color: kDarkPurpleColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: deviceSize.width,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: kPrimaryColor.withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Image.network(
                        "https://picsum.photos/200/300",
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            PhosphorIconsBold.user,
                            size: 40,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Coded",
                      style: TextStyle(
                        fontSize: 16,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () {},
                      child: Container(
                        width: 120,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kPrimaryColor,
                        ),
                        child: const Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 14,
                            color: kWhiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ProfileBtnWidget(
                onPressed: () {},
                title: 'Add Payment Methods',
              ),
              const SizedBox(height: 20),
              ProfileBtnWidget(
                onPressed: () {},
                title: 'My Earnings & Payout',
              ),
              const SizedBox(height: 60),
              ProfileBtnWidget(
                onPressed: () {},
                title: 'Manage Your Privacy Settings',
              ),
              const SizedBox(height: 20),
              ProfileBtnWidget(
                onPressed: () {},
                title: "FAQ's & Support",
              ),
              const SizedBox(height: 60),
              ProfileBtnWidget(
                onPressed: () {
                  pushReplacementWithoutNavBar(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnboardingScreen()));

                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(
                  //         builder: (context) => const OnboardingScreen()),
                  //     (Route<dynamic> route) => false);
                },
                title: 'Logout',
                isIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
