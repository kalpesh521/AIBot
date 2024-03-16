import 'package:ai/Provider/auth_provider.dart';
import 'package:ai/Screens/bottom_nav_bar.dart';
import 'package:ai/Screens/chat_screen.dart';
import 'package:ai/Services/assets_manager.dart';
import 'package:ai/Widget/appbar.dart';
import 'package:ai/Widget/bottom_navbar.dart';
import 'package:ai/Widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
         bottomNavigationBar: BottomNav(),
      ),
    );
  }
}
