import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paymate/Home/Screens/home.dart';
import 'package:paymate/Profile/screens/profile_screen.dart';
import 'package:paymate/Transactions/screens/transaction_screen.dart';
import 'package:paymate/apptheme/colors/colors_app.dart';
import 'package:paymate/helpers/others.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  double iconSize = 35;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setStatusBarColor(Colors.white54, Brightness.light);

    return SafeArea(
      child: Material(
        child: PersistentTabView(
          backgroundColor: colorGrey4,
          margin: const EdgeInsets.only(bottom: 0),
          tabs: [
            // home tap
            PersistentTabConfig(
              screen: const HomeScreen(),
              item: ItemConfig(
                iconSize: iconSize,
                activeForegroundColor: kDarkPurpleColor,
                inactiveForegroundColor: Colors.grey.shade400,
                icon: const Icon(
                  PhosphorIconsThin.house,
                  color: kDarkPurpleColor,
                ),
                inactiveIcon: Icon(
                  PhosphorIconsThin.house,
                  color: Colors.grey.shade400,
                ),
                title: "Home",
              ),
            ),

            // Transaction tab
            PersistentTabConfig(
              screen: const TransactionScreen(),
              item: ItemConfig(
                iconSize: 40,
                activeForegroundColor: kPrimaryColor,
                inactiveForegroundColor: kSecondaryGreyTextColor,
                icon: const Icon(
                  PhosphorIconsThin.contactlessPayment,
                  color: Colors.white,
                ),
                inactiveIcon: Icon(
                  PhosphorIconsThin.contactlessPayment,
                  color: Colors.grey.shade400,
                ),
                title: "Transaction",
              ),
            ),

            // Profile / Settings tab
            PersistentTabConfig(
              screen: const ProfileScreen(),
              item: ItemConfig(
                iconSize: iconSize,
                activeForegroundColor: kDarkPurpleColor,
                inactiveForegroundColor: Colors.grey.shade400,
                icon: const Icon(
                  PhosphorIconsThin.user,
                  color: kDarkPurpleColor,
                ),
                inactiveIcon: Icon(
                  PhosphorIconsThin.user,
                  color: Colors.grey.shade400,
                ),
                title: "Profile",
              ),
            ),
          ],
          stateManagement: false,
          navBarHeight: 65,
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          screenTransitionAnimation: const ScreenTransitionAnimation(
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarBuilder: (navBarConfig) => Style13BottomNavBar(
            navBarDecoration: NavBarDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            navBarConfig: navBarConfig,
          ),
        ),
      ),
    );
  }
}
