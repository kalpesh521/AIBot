import 'package:flutter/material.dart';

class  ImgGenScreen extends StatefulWidget {
  const  ImgGenScreen({super.key});

  @override
  State< ImgGenScreen> createState() => _ImgGenScreenState();
}

class _ImgGenScreenState extends State< ImgGenScreen> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
         body: Center(
            child:Text('IMG GEN Screen'),
         )
    );
  }
}