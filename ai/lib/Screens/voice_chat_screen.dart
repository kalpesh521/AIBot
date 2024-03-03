import 'package:ai/Services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ai/Widget/appbar.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceChatScreen extends StatefulWidget {
  const VoiceChatScreen({Key? key}) : super(key: key);

  @override
  State<VoiceChatScreen> createState() => _VoiceChatScreenState();
}

class _VoiceChatScreenState extends State<VoiceChatScreen> {
  var _isListening = false;
  late String globalText = '';
  SpeechToText speechToText = SpeechToText();
  FlutterTts fluttertts = FlutterTts();
 
  Future<void> systemSpeak(String content) async {
    await fluttertts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    fluttertts.stop();
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Scaffold(
      appBar: AppBarWidget(
        showBackButton: true,
        title: 'VoiceChat',
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 70),
                child: Image(
                  image: AssetImage('assets/images/sound.png'),
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            Text(
              globalText,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50.0),
        child: AvatarGlow(
          glowShape: BoxShape.circle,
          animate: _isListening,
          duration: Duration(milliseconds: 2000),
          glowColor: Theme.of(context).colorScheme.secondary,
          repeat: true,
          startDelay: Duration(milliseconds: 100),
          glowCount: 5,
          glowRadiusFactor: 0.7,
          curve: Curves.fastOutSlowIn,
          child: GestureDetector(
            onTap: () async {
              if (!_isListening) {
                var available = await speechToText.initialize();
                if (available) {
                  setState(() {
                    _isListening = true;
                    speechToText.listen(onResult: (result) {
                      setState(() async {
                        var text = result.recognizedWords;
                        print("============================ Voice Text: $text");
                        globalText = text;
                      });
                    });
                  });
                }
              } else {
                speechToText.stop();
                setListeningState(false);
                print("final$globalText");
                var speech = await apiService.chatGPTAPI(globalText);
                await systemSpeak(speech);

                print("============================ Openai response:$speech");
              }
            },
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .secondary, // Avatar background color
              child: Icon(
                _isListening ? Icons.stop : Icons.mic,
                color: Theme.of(context)
                    .colorScheme
                    .primary, // Icon color based on listening state
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setListeningState(bool isListening) {
    setState(() {
      _isListening = isListening;
    });
  }
}
