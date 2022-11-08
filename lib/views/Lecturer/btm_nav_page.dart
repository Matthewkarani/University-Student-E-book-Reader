import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:treepy/views/Lecturer/report_pages/lec_reports_home.dart';

import '../../app_styles.dart';
import 'Course_Materials/Topics/topics_content/topic_content_landingpage.dart';
import 'Course_Materials/Personas/lec_persona_list.dart';
import 'Home/Home_lec.dart';
import 'Course_Materials/Personas/create_persona.dart';
import 'Profile/profile_page.dart';

class LecBtmNav extends StatefulWidget {
  const LecBtmNav({Key? key}) : super(key: key);

  @override
  State<LecBtmNav> createState() => _LecBtmNav();
}

class _LecBtmNav extends State<LecBtmNav> {

  late PersistentTabController _controller;

  List<Widget> _buildScreens() {
    return [
      LecHome(),
      mypersonas(),
      LecReport(),
      LecsProfile()

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
    icon: Icon(CupertinoIcons.book),
    title: ("Personas"),
    activeColorPrimary: customBrown,
    inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.chart_bar_circle_fill),
        title: ("Reports"),
        activeColorPrimary: customBrown,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
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
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
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
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
