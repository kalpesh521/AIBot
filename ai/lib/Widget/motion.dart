 import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class MotionTabBarWidget extends StatefulWidget {
  const MotionTabBarWidget({Key? key}) : super(key: key);

  @override
  _MotionTabBarWidgetState createState() => _MotionTabBarWidgetState();
}

class _MotionTabBarWidgetState extends State<MotionTabBarWidget>
    with TickerProviderStateMixin {
  late MotionTabBarController _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 2,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _motionTabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MotionTabBar(
      controller: _motionTabBarController,
      initialSelectedTab: "Home",
      useSafeArea: true,
      labels: const ["Profile", "Home", "Settings"],
      icons: const [Icons.people_alt_rounded, Icons.home, Icons.settings],
      tabBarHeight: 55,
      textStyle: TextStyle(
        fontSize: 13,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      tabIconColor:  Theme.of(context).colorScheme.secondary,
      tabIconSize: 28.0,
      tabIconSelectedSize: 26.0,
      tabSelectedColor:Theme.of(context).colorScheme.secondary,
      tabIconSelectedColor: Theme.of(context).colorScheme.primary,
      tabBarColor:Theme.of(context).colorScheme.primary,
      onTabItemSelected: (int value) {
        setState(() {
          _motionTabBarController.index = value;
        });
      },
    );
  }
}
