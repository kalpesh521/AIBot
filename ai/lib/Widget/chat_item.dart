import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ai/Services/assets_manager.dart';
import 'package:ai/Widget/text_widget.dart';

class ChatItem extends StatelessWidget {
  final String msg;
  final int isMe;
  const ChatItem({
    Key? key,
    required this.msg,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isMe == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isMe != 0) ProfileContainer(isMe: isMe),
          if (isMe != 0) const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.all(15),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.80,
            ),
            decoration: BoxDecoration(
              color: isMe != 0
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: Radius.circular(isMe != 0 ? 0 : 15),
                bottomRight: Radius.circular(isMe != 0 ? 15 : 0),
              ),
            ),
            child: isMe == 0
                ? TextWidget(label: msg)
                : DefaultTextStyle(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      repeatForever: false,
                      totalRepeatCount: 1,
                      displayFullTextOnTap: true,
                      animatedTexts: [TyperAnimatedText(msg.trim())],
                    ),
                  ),
          ),
          if (isMe == 0) const SizedBox(width: 5),
          if (isMe == 0) ProfileContainer(isMe: isMe),
        ],
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    Key? key,
    required this.isMe,
  }) : super(key: key);

  final int isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 35,
      height: 35,
      child: isMe == 0
          ? Image.asset(AssetsManager.userImage) // User Image
          : Image.asset(AssetsManager.botImage), // Bot Image
    );
  }
}
