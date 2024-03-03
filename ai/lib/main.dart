import 'package:ai/Constants/theme.dart';
import 'package:ai/Provider/ChatProvider.dart';
import 'package:ai/Provider/voice_provider.dart';
import 'package:ai/Screens/chat_screen.dart';
import 'package:ai/Screens/home_screen.dart';
import 'package:ai/Screens/imggen_screen.dart';
import 'package:ai/Screens/voice_chat_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => VoiceProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          // home: HomeScreen(),
          // initialRoute: '/home', 
          // routes: {
          //   '/home': (context) => HomeScreen(),
          // }
          // home: ChatScreen(),
          //  home: VoiceChatScreen(),
           home: ImgGenScreen(),
          ),
    );
  }
}
