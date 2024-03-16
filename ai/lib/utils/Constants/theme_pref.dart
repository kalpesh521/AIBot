import 'package:shared_preferences/shared_preferences.dart';

class ThemePref {
  static const THEME_TYPE = "THEME_TYPE";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_TYPE, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_TYPE) ?? false;
  }
}
