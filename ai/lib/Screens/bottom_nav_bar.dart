import 'package:ai/Screens/home_screen.dart';
import 'package:ai/Screens/main_home_screen.dart';
import 'package:ai/Screens/profile_screen.dart';
import 'package:ai/Screens/settings_screen.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BottomNav extends StatefulWidget {
  @override
  State<BottomNav> createState() => _BottomNavstate();
}

class _BottomNavstate extends State<BottomNav> {
  final PageController _pageController = PageController(initialPage: 1);
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          EditProfilePage(),
          MainHomeScreen(),  
          SettingScreen(),

         ],
        onPageChanged: (index) {
          _controller.index = index;
        },
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        showShadow: true,
        notchBottomBarController: _controller,
        color: Theme.of(context).colorScheme.primary,
        showLabel: false,
        shadowElevation: 5,
        kBottomRadius: 10.0,
        notchColor: Colors.blue,
        removeMargins: false,
        bottomBarWidth: 500,
        durationInMilliSeconds: 300,
        elevation: 1,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(Icons.person,
                color: Theme.of(context).colorScheme.secondary),
            activeItem: Icon(Icons.person,
                color: Theme.of(context).colorScheme.primary),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.home_filled,
                color: Theme.of(context).colorScheme.secondary),
            activeItem: Icon(Icons.home_filled,
                color: Theme.of(context).colorScheme.primary),
            itemLabel: 'Profile',
          ),
          
          BottomBarItem(
            inActiveItem: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.secondary),
            activeItem: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.primary),
            itemLabel: 'Settings',
          ),
        ],
        onTap: (index) {
          _controller.index = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
        kIconSize: 20.0,
      ),
    );
  }
}
