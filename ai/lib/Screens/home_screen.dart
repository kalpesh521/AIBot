import 'package:ai/Screens/chat_screen.dart';
import 'package:ai/Services/assets_manager.dart';
import 'package:ai/Widget/appbar.dart';
import 'package:ai/Widget/bottom_navbar.dart';
import 'package:ai/Widget/card_widget.dart';
import 'package:ai/Widget/motion.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        //  AppBar
        appBar: const AppBarWidget(
          title: 'Genie.AI',
          showBackButton: false,  
        ),

        // Body of the scaffold
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome John ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                Text(
                  "I'm your Assistant !",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      height: 45,
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.onTertiary,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              child: Image.asset('assets/icons/chat.png'),
                            ),
                            SizedBox(width: 12),
                            Text(
                              "Let's Chat",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 18,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardWidget(
                            image: 'assets/images/chat-bot.png',
                            headline: 'ChatGPT',
                            description:
                                'AI conversational agent delivers contextually relevant responses',
                          ),
                          CardWidget(
                            image: 'assets/images/voice_chat.png',
                            headline: 'AI Voice Chat',
                            description:
                                'Voice-based interaction capabilities with AI system',
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardWidget(
                            image: 'assets/images/ai_img.png',
                            headline: 'DALL·E 3 ImgGen',
                            description:
                                'Easily translate your ideas into exceptionally accurate images',
                          ),
                          CardWidget(
                            image: 'assets/images/pdf.png',
                            headline: 'PDF.ai',
                            description:
                                'You can ask questions, get summaries and more',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // bottomBavigationBar of  the scaffold
        bottomNavigationBar: MotionTabBarWidget(),
      ),
    );
  }
}
