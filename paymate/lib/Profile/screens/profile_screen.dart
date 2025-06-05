// lib/Profile/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:paymate/Profile/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:paymate/Profile/screens/my_earnings_payout_screen.dart';
import 'package:paymate/Profile/screens/privacy_settings_screen.dart';
import 'package:paymate/Profile/screens/faq_support_screen.dart';
import 'package:paymate/Profile/widgets/profile_btn_widget.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';
import 'package:paymate/onboarding/screens/main_onboading_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../onboarding/onboarding_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProv = Provider.of<UserProvider>(context, listen: false);
      if (!userProv.isLoading) {
        _nameController.text = userProv.userName;
      } else {
        userProv.addListener(() {
          if (!userProv.isLoading) {
            _nameController.text = userProv.userName;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showEditProfileBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 150,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: kDarkPurpleColor,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final newName = _nameController.text.trim();
                  if (newName.isEmpty) return;

                  final userProv = Provider.of<UserProvider>(
                    context,
                    listen: false,
                  );
                  await userProv.setUserName(newName);

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProv, child) {
        if (userProv.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final currentName = userProv.userName;
        _nameController.text = currentName;
        final deviceSize = MediaQuery.of(context).size;

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
                children: [
                  // ─────────── User Info ───────────
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              "https://picsum.photos/500/500",
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  PhosphorIconsBold.user,
                                  size: 40,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          currentName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          borderRadius: BorderRadius.circular(40),
                          onTap: _showEditProfileBottomSheet,
                          child: Container(
                            width: 120,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: kPrimaryColor,
                            ),
                            child: const Text(
                              "Edit Profile",
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

                  // ─────────── Buttons to navigate ───────────
                  ProfileBtnWidget(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MyEarningsPayoutScreen(),
                        ),
                      );
                    },
                    title: 'My Earnings & Payout',
                  ),
                  const SizedBox(height: 20),
                  ProfileBtnWidget(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PrivacySettingsScreen(),
                        ),
                      );
                    },
                    title: 'Manage Your Privacy Settings',
                  ),
                  const SizedBox(height: 20),
                  ProfileBtnWidget(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const FAQSupportScreen(),
                        ),
                      );
                    },
                    title: "FAQ's & Support",
                  ),

                  const SizedBox(height: 60),
                  ProfileBtnWidget(
                    onPressed: () {
                      // 1) Reset onboarding so that next app launch shows it again:
                      Provider.of<OnboardingProvider>(context, listen: false)
                          .reset();

                      // 2) Navigate to the onboarding screen, clearing the stack:
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => const OnboardingScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    title: 'Logout',
                    isIcon: false,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
