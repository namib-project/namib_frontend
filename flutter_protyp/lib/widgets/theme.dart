import 'package:flutter/material.dart';

/// Is used for the general theme of the application
/// It's usage can be seen in main.dart
/// setTheme should only be used in settings.dart
class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }
}
