import 'package:ai/Widget/appbar.dart';
import 'package:flutter/material.dart';

class  PdfScreen extends StatefulWidget {
  const  PdfScreen({super.key});

  @override
  State< PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State< PdfScreen> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: AppBarWidget(title:  'PDF.ai'),
         body: Center(
            child:Text('PDF Screen'),
         )
    );
  }
}