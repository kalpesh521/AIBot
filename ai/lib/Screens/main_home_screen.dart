import 'package:ai/Provider/auth_provider.dart';
import 'package:ai/Screens/chat_screen.dart';
import 'package:ai/Widget/appbar.dart';
import 'package:ai/Widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool? exitapp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure ?'),
          content: Text("Do you want to exit ?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
    return exitapp ?? false;
  }

  @override
  Widget build(BuildContext context) {
    ProviderState _providerState =
        Provider.of<ProviderState>(context, listen: false);

    return SafeArea(
      child: Scaffold(
         appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + MediaQuery.of(context).padding.top),
          child: AppBarWidget(
            title: 'Genie.AI',
            showBackButton: false,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(
                          text: "Hello ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        TextSpan(
                          text: "${_providerState.getFirstName.toString()}.",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "I'm your AI Assistant !",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  SizedBox(height: 5),
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
                                builder: (context) => ChatScreen(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.onTertiary,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Explore',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
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
                          image: 'assets/images/hire.png',
                          headline: 'InterviewPrep.ai',
                          description:
                              'Get Interview-Ready with AI-Automated Interview Platform',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
