import 'package:ai/Models/Models.dart';
import 'package:ai/Services/api_service.dart';
import 'package:flutter/cupertino.dart';

class ModelsProvider with ChangeNotifier {
  // String currentModel = "text-davinci-003";
  String currentModel = "gpt-3.5-turbo-0301";

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<Models> modelsList = [];

  List<Models> get getModelsList {
    return modelsList;
  }

  Future<List<Models>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}
