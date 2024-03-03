import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceProvider with ChangeNotifier {
  String Words = "";
  final SpeechToText speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;

  bool get isInitialized => _speechEnabled;
  bool get isListening => _isListening;

  void initSpeech() async {
    _speechEnabled = await speechToText.initialize(onError: (error) {
      print("Speech to text error: $error");
    }, onStatus: (status) {
      _isListening = status == "listening";
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> startListening() async {
    if (_speechEnabled) {
      speechToText.listen(onResult: (result) {
        if (result.finalResult || result.recognizedWords.isNotEmpty) {
          Words = result.recognizedWords;
          notifyListeners();
        }
      });
    }
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    notifyListeners();
  }

  void setListeningState(bool bool) {}
  
}