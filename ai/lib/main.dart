import 'package:ai/Constants/theme.dart';
import 'package:ai/Provider/ChatProvider.dart';
import 'package:ai/Provider/auth_provider.dart';
import 'package:ai/Provider/voice_provider.dart';
import 'package:ai/Screens/chat_screen.dart';
import 'package:ai/Screens/home_screen.dart';
import 'package:ai/Screens/imggen_screen.dart';
import 'package:ai/Screens/login_screen.dart';
import 'package:ai/Screens/registration_screen.dart';
import 'package:ai/Screens/voice_chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey:
        "AIzaSyBwWP_PHK2GLo6SrN6kINSANhCitAVSyPs", // paste your api key here
    appId:
        "1:42380437700:android:36b4179efb31daf7958191", //paste your app id here
    messagingSenderId: "42380437700", //paste your messagingSenderId here
    projectId: "aibot-229dd", //paste your project id here
  ));
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
        ChangeNotifierProvider(
          create: (_) => ProviderState(),
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
        //  home: ImgGenScreen(),
        // home: ProviderLogin(),
        home: ProviderRegistration(),
      ),
    );
  }
}
