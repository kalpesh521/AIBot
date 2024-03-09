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
  FlutterTts fluttertts = FlutterTts();
  late String globalText = '';
  String? speechm;
  SpeechToText speechToText = SpeechToText();
  var _isListening = false;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> initTextToSpeech() async {
    await fluttertts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> systemSpeak(String content) async {
    await fluttertts.speak(content);
  }

  void setListeningState(bool isListening) {
    setState(() {
      _isListening = isListening;
    });
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
                padding: EdgeInsets.only(top: 80),
                child: Image(
                  image: AssetImage('assets/images/bot.png'),
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Visibility(
              visible: !_isListening,
              child: Text.rich(
                TextSpan(
                  text: 'Tap the mic\n to start speaking',
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
                textAlign: TextAlign.center,
              ),
            ),
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
                          globalText = text;
                        });
                      });
                    });
                  }
                } else {
                  speechToText.stop();
                  setListeningState(false);
                  var speech = await apiService.chatGPTAPI(globalText);
                  await systemSpeak(speech);
                }
              },
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Icon(
                  _isListening ? Icons.stop : Icons.mic,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          )),
    );
  }
}
