import 'package:ai/Services/assets_manager.dart';
import 'package:ai/Widget/text_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatindex});

  @override
  final String msg;
  final int chatindex;

  Widget build(BuildContext context) {
    return Column(children: [
      Material(
        color: chatindex == 0
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.onSecondary,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                chatindex == 0
                    ? AssetsManager.userImage
                    : AssetsManager.botImage,
                height: 30,
                width: 30,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: chatindex == 0
                  ? TextWidget(label: msg)
                  : DefaultTextStyle(
                      style: TextStyle(
                        color:  Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      child: AnimatedTextKit(
                          isRepeatingAnimation: false,
                          repeatForever: false,
                          totalRepeatCount: 1,
                          displayFullTextOnTap: true,
                          animatedTexts: [TyperAnimatedText(msg.trim())])),
            ),
          ],
        ),
      )
    ]);
  }
}
