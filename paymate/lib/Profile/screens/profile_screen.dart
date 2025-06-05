// lib/Profile/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:paymate/Profile/user_provider.dart';
import 'package:provider/provider.dart';
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
  // We keep a TextEditingController to edit the name in the bottom sheet.
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    // Initialize with an empty controller; we will set its text when provider is loaded.
    _nameController = TextEditingController();

    // As soon as the provider finishes loading (isLoading==false), we'll set _nameController.text.
    // We can listen to the provider to know when it’s done.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProv = Provider.of<UserProvider>(context, listen: false);
      if (!userProv.isLoading) {
        _nameController.text = userProv.userName;
      } else {
        // If still loading, wait until it updates:
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

                  // 1) Update UserProvider (which also writes to SharedPreferences).
                  final userProv = Provider.of<UserProvider>(
                    context,
                    listen: false,
                  );
                  await userProv.setUserName(newName);

                  // 2) Close the bottom sheet.
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
    // Listen to UserProvider so that whenever userName changes, this widget rebuilds.
    return Consumer<UserProvider>(
      builder: (context, userProv, child) {
        // If provider is still loading, show a spinner:
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
                  // ─────────── User Info Header ───────────
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
                          builder: (context) => const OnboardingScreen(),
                        ),
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
