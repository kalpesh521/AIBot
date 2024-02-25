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
         body: Center(
            child:Text('PDF Screen'),
         )
    );
  }
}