import 'package:ai/Services/assets_manager.dart';
import 'package:flutter/material.dart';

class  AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? color; // New parameter for color

  const  AppBarWidget({Key? key, required this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? Colors.white, // Use the provided color or default to white
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
