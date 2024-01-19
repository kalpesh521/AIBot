import 'package:ai/Provider/ChatProvider.dart';
import 'package:ai/Provider/ModelProvider.dart';
import 'package:ai/Screens/chat_screen.dart';
import 'package:ai/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

void main() {
   
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
   return  MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => ChatProvider(),
        // ),
      ],
   child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: ScaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: CardColor,
          )),
      home: ChatScreen(),
    ),
   );
  }
}

