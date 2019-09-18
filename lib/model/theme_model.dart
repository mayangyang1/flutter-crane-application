import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel with ChangeNotifier {
  int  _themeColorIndex =0;
  int get value => _themeColorIndex;

  void changeThemeColor(int  value) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setInt('themeColorIndex', value);
    _themeColorIndex = value;
    notifyListeners();
  }
}