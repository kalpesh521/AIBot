import 'package:ai/Widget/dropdown_model.dart';
import 'package:flutter/material.dart';

import '../Widget/text_widget.dart';

class Services {
  static Future<void> showModelSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        backgroundColor: Color.fromARGB(175, 31, 30, 30),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Flexible(
                    child: TextWidget(
                  label: "Choose Model",
                  fontSize: 16,
                  color: Colors.white,
                )),
                SizedBox(width: 10,),
                Flexible(  
                  // flex: 5,
 child: DropdownModel())
              ],
            ),
          );
        });
  }
}
