import 'package:ai/Services/assets_manager.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const AppBarWidget(
      {Key? key, this.showBackButton = true, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: showBackButton ? BackButton(color: Theme.of(context).colorScheme.secondary): null,
      automaticallyImplyLeading: false,
      leadingWidth: 100,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      backgroundColor: Theme.of(context)
          .colorScheme
          .onSecondary, // Use the provided color or default to white
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
