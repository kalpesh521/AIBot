import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  fontFamily: 'Poppins',
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Color(0xFF5393f3),
        onSecondary: Color(0xFFf1f1f1),
        tertiary: Color.fromARGB(255, 125, 125, 125),
        onTertiary: Color.fromARGB(255, 226, 255, 254),
      ),
);

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: Colors.blueGrey,
        onPrimary: Colors.white,
        secondary: Colors.blueGrey,
        onSecondary: Colors.white,
        tertiary: Color(0xFFff6f00),
        onTertiary: Color(0xFF000000),
      ),
  textTheme: ThemeData.dark().textTheme.copyWith(
        bodyText1: TextStyle(fontFamily: 'Poppins'),
        bodyText2: TextStyle(fontFamily: 'Poppins'),
        // You can specify more text styles here if needed
      ),
);
