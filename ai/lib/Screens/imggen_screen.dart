import 'dart:io';
import 'dart:ui';
import 'package:ai/Services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ai/Widget/appbar.dart';
import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class ImgGenScreen extends StatefulWidget {
  ImgGenScreen({Key? key}) : super(key: key);
  @override
  State<ImgGenScreen> createState() => _ImgGenScreenState();
}

class _ImgGenScreenState extends State<ImgGenScreen> {
  FlutterTts fluttertts = FlutterTts();
  late String globalText = '';
  String? generatedImageUrl;
  SpeechToText speechToText = SpeechToText();
  var _isListening = false;
  var _isLoading = false;
  final GlobalKey globalKey = GlobalKey();

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

  Future<File> captureImage(GlobalKey globalKey) async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List uint8List = byteData!.buffer.asUint8List();
    final Directory tempDir = await getTemporaryDirectory();
    File file = File('${tempDir.path}/image.png');
    await file.writeAsBytes(uint8List);
    return file;
  }

  void shareImage(File imageFile) {
    Share.shareFiles([imageFile.path]);
  }

  void shareGeneratedImage() async {
    if (generatedImageUrl != null) {
      File imageFile = await captureImage(globalKey);
      shareImage(imageFile);
    }
  }

  _saveLocalImage() async {
    if (globalKey.currentContext != null) {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {
        final result =
            await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
        print(result);
        if (result != null && result.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Image Downloaded Successfully!'),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to Download image!'),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        print('Error: Failed to capture image data.');
      }
    } else {
      print(
          "Error: RenderObject not found. Ensure globalKey is associated with a valid context.");
    }
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
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
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
              SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Image(
                    image: AssetImage('assets/images/bot.png'),
                    height: 130,
                    width: 130,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20.0),
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
                    if (generatedImageUrl != null && !_isLoading)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 270,
                          height: 270,
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
                          child: RepaintBoundary(
                            key: globalKey,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                generatedImageUrl!,
                                width: 270,
                                height: 270,
                                fit: BoxFit.cover,
                              ),
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
        padding: const EdgeInsets.only(bottom: 70.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Visibility(
              visible:
                  generatedImageUrl != null && !_isListening && !_isLoading,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Color.fromARGB(255, 72, 196, 91),
                onPressed: () async {
                  await _saveLocalImage();
                },
                child: Icon(Icons.download, size: 20, color: Colors.white),
              ),
            ),
            SizedBox(width: 20),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.onSecondary,
                    offset: Offset(4, 4),
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
                              globalText = text;
                            });
                          });
                        });
                      }
                    } else {
                      setLoadingState(true);
                      speechToText.stop();
                      setListeningState(false);
                      generatedImageUrl = await apiService.dallEAPI(globalText);
                      setLoadingState(false);
                      shareGeneratedImage();
                      setState(() {});
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
              ),
            ),
            SizedBox(width: 20),
            Visibility(
              visible:
                  generatedImageUrl != null && !_isListening && !_isLoading,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Color.fromARGB(255, 72, 196, 91),
                onPressed: () async {
                  File imagefile = await captureImage(globalKey);
                  shareImage(imagefile);
                },
                child: Icon(Icons.share, size: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
