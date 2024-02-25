import 'package:ai/Models/chat_model.dart';
import 'package:ai/Provider/ChatProvider.dart';
import 'package:ai/Provider/ModelProvider.dart';
import 'package:ai/Services/api_service.dart';
import 'package:ai/Services/assets_manager.dart';
import 'package:ai/Services/model_sheet.dart';
import 'package:ai/Widget/appbar.dart';
import 'package:ai/Widget/chat_item.dart';
import 'package:ai/Widget/chat_widget.dart';
import 'package:ai/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  String currentmodel = "gpt-3.5-turbo";
  late FocusNode focusNode;
  late ScrollController _listScrollController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    _listScrollController = ScrollController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBarWidget(
        title: 'ChatGPT',
        color: Colors.blue.shade50,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            
            children: [
              Flexible(
                child: ListView.builder(
                  controller: _listScrollController,
                  itemCount: chatProvider.getChatList.length,
                  itemBuilder: (context, index) {
                    return ChatItem(
                        msg: chatProvider.getChatList[index].msg,
                        isMe: chatProvider.getChatList[index].chatIndex);
                  },
                ),
              ),
              if (_isTyping)
                SpinKitThreeBounce(
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 18,
                ),
              // SizedBox(
              //   height: 20,
              // ),
              Material(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSecondary,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary
                                    .withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextField(
                            focusNode: focusNode,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 16),
                            controller: textEditingController,
                            cursorColor: Theme.of(context).colorScheme.tertiary,
                            onSubmitted: (value) async {
                              await sendMessagesFCT(chatProvider);
                            },
                            decoration: InputDecoration(
                              hintText: "How can I help you ?",
                              hintStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                              border: InputBorder.none,

                              suffixIcon: IconButton(
                                onPressed: () async {
                                  await sendMessagesFCT(chatProvider);
                                },
                                icon: Icon(Icons.send,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              //******************* */
                              // suffixIcon: IconButton(
                              //   icon: Icon(Icons.mic,
                              //       color:
                              //           Theme.of(context).colorScheme.secondary),
                              //   onPressed: () async {
                              //     // await  Services.showModelSheet(context: context);
                              //   },
                              // ),
                            ),
                          ),
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () async {
                      //     await sendMessagesFCT(chatProvider);
                      //   },
                      //   icon: Icon(Icons.send,
                      //       color: Theme.of(context).colorScheme.secondary),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void ScrollList() {
    _listScrollController.animateTo(
      _listScrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessagesFCT(ChatProvider chatProvider) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              TextWidget(label: "You can't type multiple messages at a time"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(label: "Please type a Message"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      String msg = textEditingController.text;

      setState(() {
        _isTyping = true;
        chatProvider.addMessages(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAns(
        msg: msg,
        model: currentmodel,
      );

      setState(() {});
    } catch (e) {
      print("error $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(label: e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        ScrollList();
        _isTyping = false;
      });
    }
  }
}
