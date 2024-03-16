import 'package:ai/Provider/theme_provider.dart';
import 'package:ai/Screens/InterviewPrep_ai_screen.dart';
import 'package:ai/Screens/main_home_screen.dart';
import 'package:ai/Screens/signIn_screen.dart';
import 'package:ai/Screens/get_started_screen.dart';
import 'package:ai/Screens/settings_screen.dart';
import 'package:ai/Screens/signUp_screen.dart';
import 'package:ai/Screens/splash_screen.dart';
import 'package:ai/utils/Constants/theme.dart';
import 'package:ai/Provider/ChatProvider.dart';
import 'package:ai/Provider/auth_provider.dart';
import 'package:ai/Provider/voice_provider.dart';
import 'package:ai/Screens/chat_screen.dart';
import 'package:ai/Screens/home_screen.dart';
import 'package:ai/Screens/imggen_screen.dart';
import 'package:ai/Screens/profile_screen.dart';
import 'package:ai/Screens/voice_chat_screen.dart';
import 'package:ai/utils/Constants/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isDarkMode = false;

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  ThemeProvider themeChangeProvider = ThemeProvider();
  void getCurrentTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.themePref.getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentTheme();
    super.initState();
  }

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
        ChangeNotifierProvider(
          create: (_) =>
              themeChangeProvider,  
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.getTheme(),
          themeMode: ThemeMode.system,
          home: SplashScreen(),
          // home: SettingScreen(),
        );
      }),
    );
  }
}
       



 // initialRoute: '/home',
          // routes: {
          //   '/home': (context) => MainHomeScreen(),
          //   '/profile': (context) => EditProfilePage(),
          //   '/settings': (context) =>
          //       SettingScreen(toggleDarkMode: toggleDarkMode),
          // },