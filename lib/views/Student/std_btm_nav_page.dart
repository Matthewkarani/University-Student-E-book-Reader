import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../app_styles.dart';
import 'Enroll/stud_enroll_to_persona.dart';
import 'Home/stud_home_page.dart';
import 'Materials/Content/PdfReaderPage.dart';
import 'Home/mypersonas.dart';
import 'Materials/Personas/stud_persona_list.dart';
import 'Materials/Scheduler/Schedule_home.dart';
import 'Materials/stud_persona_materials.dart';
import 'Profile/stud_profile.dart';

class StdLanding extends StatefulWidget {
  const StdLanding({Key? key}) : super(key: key);

  @override
  State<StdLanding> createState() => _StdLandingState();
}

class _StdLandingState extends State<StdLanding> {

  late PersistentTabController _controller;

  List<Widget> _buildScreens() {
    return [
      studPersonas(),
      scheduler_home(),
      // EnrollPersona(),
      studProfile()

    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: customBrown,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.clock),
        title: ("Schedules"),
        activeColorPrimary: customBrown,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(CupertinoIcons.search_circle),
      //   title: ("Enroll"),
      //   activeColorPrimary: customBrown,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: ("Profile"),
        activeColorPrimary: customBrown,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
    Widget build(BuildContext context) {
      _controller = PersistentTabController(initialIndex: 0);

      return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle
            .style1, // Choose the nav bar style with this property.
      );
    }
  }

