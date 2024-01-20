import 'package:ai/Models/chat_model.dart';
import 'package:ai/Services/api_service.dart';
import 'package:flutter/foundation.dart';

class ChatProvider with ChangeNotifier {
  List<chatModel> chatList = [];
  List<chatModel> get getChatList {
    return chatList;
  }

  void addMessages({required String msg}) {
    chatList.add(chatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAns(
      {required String msg, required String model}) async {
    chatList.addAll(await ApiService.sendMessage(
      message: msg,
      modelId: model,
    ));
    notifyListeners();
  }
}
