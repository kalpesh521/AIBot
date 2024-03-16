import 'package:ai/utils/Constants/theme.dart';
import 'package:ai/utils/Constants/theme_pref.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemePref themePref = ThemePref();
  bool _darkTheme = false;

  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    themePref.setDarkTheme(value);
    notifyListeners();
  }
   ThemeData getTheme() {
    return _darkTheme ? darkTheme : lightTheme;
  }
}
