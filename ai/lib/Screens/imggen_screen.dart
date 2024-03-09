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
    return Material(
        color:Theme.of(context).colorScheme.secondary,
        child: Scaffold(
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
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isLoading)
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Generating image...',
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.tertiary),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    if (generatedImageUrl != null && !_isLoading)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.5),
                                offset: Offset(4, 4),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(-2, -2),
                                blurRadius: 3,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              generatedImageUrl!,
                              width: 250,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 40,
                    ),
                    if (generatedImageUrl == null && !_isLoading)
                      Text.rich(
                        TextSpan(
                          text: 'Tap the mic\n to generate an image ',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.tertiary),
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50.0),
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                
                BoxShadow(
                  color:  Theme.of(context).colorScheme.onSecondary ,
                  offset: Offset(4,4 ),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
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
      ),
    ));
  }
}
