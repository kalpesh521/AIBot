import 'package:ai/Screens/chat_screen.dart';
import 'package:ai/Screens/imggen_screen.dart';
import 'package:ai/Screens/pdf_ai_screen.dart';
import 'package:ai/Screens/voice_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';

class CardWidget extends StatelessWidget {
  final String image;
  final String headline;
  final String description;

  CardWidget({
    required this.image,
    required this.headline,
    required this.description,
  });

  void navigateToScreen(BuildContext context) {
    switch (headline) {
      case 'ChatGPT':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
        break;
      case 'AI Voice Chat':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VoiceChatScreen()),
        );
        break;
      case 'DALL·E 3 ImgGen':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImgGenScreen()),
        );
        break;
      case 'PDF.ai':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PdfScreen()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () => navigateToScreen(context),
        child: Stack(
          children: [
            Container(
              width: 155,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 3),
                  ),
                ],
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      image,
                      width: 70,
                      height: 70,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    headline,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  BootstrapIcons.arrow_up_right_square,
                  size: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
