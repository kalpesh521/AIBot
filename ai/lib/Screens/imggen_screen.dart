import 'package:ai/Services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ai/Widget/appbar.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ImgGenScreen extends StatefulWidget {
  const ImgGenScreen({Key? key}) : super(key: key);

  @override
  State<ImgGenScreen> createState() => _ImgGenScreenState();
}

class _ImgGenScreenState extends State<ImgGenScreen> {
  FlutterTts fluttertts = FlutterTts();
  late String globalText = '';
  String? speechm;
  String? generatedImageUrl;
  SpeechToText speechToText = SpeechToText();
  var _isListening = false;
  var _isLoading = false;
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

  void setLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _stop() async {
    await fluttertts.stop();
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
        title: 'ImgGen',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Image(
                    image: AssetImage('assets/images/ai_img.png'),
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
              if (_isLoading)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              if (generatedImageUrl != null && !_isLoading)
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    height:250,width:250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                         ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        generatedImageUrl!,
                        width: 200, // Adjust width as needed
                        height: 200, // Adjust height as needed
                      ),
                    ),
                  ),
                ),
              if (_isLoading && generatedImageUrl == null)
                Text(
                  'Generating image...',
                  style: TextStyle(fontSize: 18),
                ),
              if (generatedImageUrl == null && !_isLoading)
                Text(
                  'Tap on the mic to generate an image',
                  style: TextStyle(fontSize: 18),
                ),
            ],
          ),
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
                          print(
                              "============================ Voice Text: $text");
                          globalText = text;
                        });
                      });
                    });
                  }
                } else {
                  setLoadingState(true);
                  speechToText.stop();
                  setListeningState(false);
                  print("final$globalText");

                  generatedImageUrl = await apiService.dallEAPI(globalText);
                  setLoadingState(false);
                  setState(() {});
                  print(generatedImageUrl);
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
          )),
    );
  }
}
