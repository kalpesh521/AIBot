import 'package:flutter/material.dart';

class  VoiceChatScreen extends StatefulWidget {
  const  VoiceChatScreen({super.key});

  @override
  State< VoiceChatScreen> createState() => _VoiceChatScreenState();
}

class _VoiceChatScreenState extends State< VoiceChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
         body: Center(
            child:Text('Voice Chat Screen'),
         )
    );
  }
}