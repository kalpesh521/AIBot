import 'dart:async';

import 'package:ai/Models/chat_model.dart';
import 'package:ai/Services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceProvider with ChangeNotifier {
  String startListen = "";

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  Future<void> startListening() async {
    final completer = Completer<String>();
    _speechToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          completer.complete(result.recognizedWords);
        }
      },
    );
    startListen = completer.future.toString();
    notifyListeners();
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  SpeechToText get speechToText => _speechToText;
  bool get isEnabled => _speechEnabled;
}
