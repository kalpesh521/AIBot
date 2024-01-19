import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'dart:math';
import 'package:ai/Constants/api_constants.dart';
import 'package:ai/Models/Models.dart';
import 'package:ai/Models/chat_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Models>> getModels() async {
    try {
      var response = await http.get(Uri.parse('$BASE_URL/models'),
          headers: {'Authorization': 'Bearer $API_KEY'});
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List temp = [];

      for (var value in jsonResponse['data']) {
        temp.add(value);
        // print("temp $value");
      }
      return Models.modelfromSnapshot(temp);
    } catch (error) {
      print("Error in getting models : $error");
      rethrow;
    }
  }

  static Future<List<chatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      log("modelId $modelId");
      var response = await http.post(
        Uri.parse("$BASE_URL/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            // "messages": [
            //   {
            //     "role": "user",
            //     "content": message,
            //   }
            // ]

            "prompt": message,
            "max_tokens": 100,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      // Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<chatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // print("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");

        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => chatModel(
            msg: jsonResponse["choices"][index]["text"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
