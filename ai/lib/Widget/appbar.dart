import 'package:ai/Provider/auth_provider.dart';
import 'package:ai/Screens/login_screen.dart';
import 'package:ai/Services/assets_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const AppBarWidget(
      {Key? key, this.showBackButton = true, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 40,
      leading: showBackButton
          ? Center(
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          : null,
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      elevation: 9,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsManager.botImage,
            width: 40.0,
            height: 40.0,
          ),
          SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
