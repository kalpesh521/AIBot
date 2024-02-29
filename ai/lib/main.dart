import 'package:ai/Constants/theme.dart';
import 'package:ai/Provider/ChatProvider.dart';
import 'package:ai/Provider/ModelProvider.dart';
import 'package:ai/Screens/chat_screen.dart';
import 'package:ai/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        // home: HomeScreen(),

        home: ChatScreen(),
      ),
    );
  }
}
