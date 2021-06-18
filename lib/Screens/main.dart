import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_chef/Screens/accounts.dart';
import 'package:home_chef/Screens/category_screen.dart';
import 'package:home_chef/Screens/orders.dart';
import 'package:home_chef/Screens/menu (2).dart';
import 'package:home_chef/Screens/payments_weekly.dart';
import 'package:home_chef/Screens/review.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [
      Orders(),
      Review(),
      Categorymenu(),
      WeeklyPayments(),
      Accounts(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          activeColorPrimary: Color(0xFF4A5397),
          icon: Icon(
            Icons.notes,
            color: Color(0xFF4A5397),
          ),
          // SvgPicture.asset("assets/codicon_list-selection-1.svg"),
          inactiveIcon: Icon(
            Icons.notes,
            color: Colors.black,
          ),
          title: 'Order'),
      PersistentBottomNavBarItem(
          activeColorPrimary: Color(0xFF4A5397),
          icon: Icon(
            Icons.rate_review,
            color: Color(0xFF4A5397),
          ),
          inactiveIcon: Icon(
            Icons.rate_review,
            color: Colors.black,
          ),
          title: 'Review'),
      PersistentBottomNavBarItem(
          activeColorPrimary: Color(0xFF4A5397),
          icon: Icon(
            Icons.restaurant_menu_outlined,
            color: Color(0xFF4A5397),
          ),
          inactiveIcon: Icon(
            Icons.restaurant_menu_outlined,
            color: Colors.black,
          ),
          title: 'Menu'),
      PersistentBottomNavBarItem(
          activeColorPrimary: Color(0xFF4A5397),
          icon: Icon(
            Icons.payment,
            color: Color(0xFF4A5397),
          ),
          inactiveIcon: Icon(
            Icons.payment,
            color: Colors.black,
          ),
          title: 'Payment'),
      PersistentBottomNavBarItem(
          activeColorPrimary: Color(0xFF4A5397),
          icon: Icon(
            Icons.person_outline,
            color: Color(0xFF4A5397),
          ),
          inactiveIcon: Icon(
            Icons.person_outline,
            color: Colors.black,
          ),
          title: 'Account'),
    ];
  }

  void navbar(selectedindex) {
    setState(() {
      index = selectedindex;
    });
  }

  Map<int, Color> color = {
    50: Color.fromRGBO(74, 83, 151, .1),
    100: Color.fromRGBO(74, 83, 151, .2),
    200: Color.fromRGBO(74, 83, 151, .3),
    300: Color.fromRGBO(74, 83, 151, .4),
    400: Color.fromRGBO(74, 83, 151, .5),
    500: Color.fromRGBO(74, 83, 151, .6),
    600: Color.fromRGBO(74, 83, 151, .7),
    700: Color.fromRGBO(74, 83, 151, .8),
    800: Color.fromRGBO(74, 83, 151, .9),
    900: Color.fromRGBO(74, 83, 151, 1),
  };
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),

      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
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
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
