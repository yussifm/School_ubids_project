// lib/Profile/screens/privacy_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({Key? key}) : super(key: key);

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _showProfileToPublic = true;
  bool _enableTwoFactorAuth = false;
  bool _shareUsageData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Settings',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text(
              'Show Profile to Public',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: const Text('Allow others to see your profile details'),
            value: _showProfileToPublic,
            activeColor: kPrimaryColor,
            onChanged: (val) {
              setState(() {
                _showProfileToPublic = val;
              });
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text(
              'Enable Two-Factor Authentication',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: const Text('Add an extra layer of security to your account'),
            value: _enableTwoFactorAuth,
            activeColor: kPrimaryColor,
            onChanged: (val) {
              setState(() {
                _enableTwoFactorAuth = val;
              });
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text(
              'Share Usage Data',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: const Text('Send anonymous usage data to improve the app'),
            value: _shareUsageData,
            activeColor: kPrimaryColor,
            onChanged: (val) {
              setState(() {
                _shareUsageData = val;
              });
            },
          ),
          const Divider(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Save changes or send to backend as needed
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy settings saved.')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Save Settings',
              style: TextStyle(
                color: kWhiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
