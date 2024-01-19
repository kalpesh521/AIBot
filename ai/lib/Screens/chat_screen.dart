import 'package:ai/Constants/constants.dart';
import 'package:ai/Models/chat_model.dart';
import 'package:ai/Provider/ModelProvider.dart';
import 'package:ai/Services/api_service.dart';
import 'package:ai/Services/assets_manager.dart';
import 'package:ai/Services/model_sheet.dart';
import 'package:ai/Widget/chat_widget.dart';
import 'package:ai/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  String currentmodel = "gpt-3.5-turbo-instruct";
  late FocusNode focusNode;
  late ScrollController _listScrollController;

  void initState() {
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    _listScrollController = ScrollController();
    super.initState();
  }

  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  List<chatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AssetsManager.botImage, // Replace with your image asset path
            width: 40.0, // Adjust the width as needed
            height: 40.0, // Adjust the height as needed
          ),
        ),
        title: Text('ChatGPT', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () async {
              // await  Services.showModelSheet(context: context);
            },
            icon: Icon(Icons.more_vert_rounded, color: Colors.white),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  controller: _listScrollController,
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatList[index].msg,
                      chatindex: chatList[index].chatIndex,
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                  color: Color.fromARGB(255, 205, 205, 205), size: 18),
            ],
            SizedBox(
              height: 20,
            ),
            Material(
              color: CardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TextField(
                          focusNode: FocusNode(),
                          style: TextStyle(color: Colors.white),
                          controller: textEditingController,
                          onSubmitted: (value) async {
                            await sendMessagesFCT();
                          },
                          decoration: InputDecoration(
                            hintText: "How can I help you?",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMessagesFCT();
                      },
                      icon: Icon(Icons.send,
                          color: Color.fromARGB(255, 64, 220, 215)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendMessagesFCT() async {
    try {
      setState(() {
        _isTyping = true;
        chatList.add(chatModel(msg: textEditingController.text, chatIndex: 0));
        textEditingController.clear();
        focusNode.unfocus();
      });
      chatList.addAll(await ApiService.sendMessage(
        message: textEditingController.text,
        modelId: currentmodel,
      ));

      setState(() {});
    } catch (e) {
      print("error $e");
    } finally {
      setState(() {
        ScrollList();
        _isTyping = false;
      });
    }
  }

  void ScrollList() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }
}
