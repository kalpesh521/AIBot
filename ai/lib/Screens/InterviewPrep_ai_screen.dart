import 'package:ai/Widget/appbar.dart';
import 'package:flutter/material.dart';

class AiObjectScreen extends StatefulWidget {
  const AiObjectScreen({super.key});

  @override
  State<AiObjectScreen> createState() => _AiObjectScreenState();
}

class _AiObjectScreenState extends State<AiObjectScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: AppBarWidget(title: 'InterviewPrep.ai'),
        body: Center(
          child: Text(' '),
        ));
  }
}
