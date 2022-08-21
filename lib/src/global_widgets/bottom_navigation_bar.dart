import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:polygon_hackathon_flutter/my_colors.dart';
import 'package:polygon_hackathon_flutter/src/pages/foundations/foundations_page.dart';
import 'package:polygon_hackathon_flutter/src/pages/login/login_page.dart';
import 'package:polygon_hackathon_flutter/src/pages/nft_list/nft_list_page.dart';
import 'package:polygon_hackathon_flutter/src/pages/register_foundation/register_foundation_page.dart';
import 'package:polygon_hackathon_flutter/src/pages/splash/splash_page.dart';

class DonatyBottomNavigationBar extends StatefulWidget {
  @override
  _DonatyBottomNavigationBarState createState() =>
      _DonatyBottomNavigationBarState();
}

List<Widget> _buildScreens() {
  return [
    // LoginPage(),
    NftListPage(),
    FoundationsPage(),
    // RegisterFoundationPage(),
    // SplashPage(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    // PersistentBottomNavBarItem(
    //   icon: Icon(Icons.home_filled),
    //   title: ("Home"),
    //   activeColorPrimary: DonatyColors.primaryColor3,
    //   inactiveColorPrimary: DonatyColors.primaryColor4,
    // ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home_filled),
      title: ("Home"),
      activeColorPrimary: DonatyColors.primaryColor3,
      inactiveColorPrimary: DonatyColors.primaryColor4,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.favorite_border),
      title: ("Foundations"),
      activeColorPrimary: DonatyColors.primaryColor3,
      inactiveColorPrimary: DonatyColors.primaryColor4,
    ),
    // PersistentBottomNavBarItem(
    //   icon: Icon(Icons.app_registration_outlined),
    //   title: ("Register"),
    //   activeColorPrimary: DonatyColors.primaryColor3,
    //   inactiveColorPrimary: DonatyColors.primaryColor4,
    // ),
    // PersistentBottomNavBarItem(
    //   icon: Icon(Icons.person),
    //   title: ("Profile"),
    //   activeColorPrimary: DonatyColors.primaryColor3,
    //   inactiveColorPrimary: DonatyColors.primaryColor4,
    // ),
    // PersistentBottomNavBarItem(
    //   icon: Icon(CupertinoIcons.settings),
    //   title: ("Register Foundations"),
    //   activeColorPrimary: DonatyColors.primaryColor3,
    //   inactiveColorPrimary: DonatyColors.primaryColor4,
    // ),
  ];
}

class _DonatyBottomNavigationBarState extends State<DonatyBottomNavigationBar> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: DonatyColors.primaryColor2, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        // borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
