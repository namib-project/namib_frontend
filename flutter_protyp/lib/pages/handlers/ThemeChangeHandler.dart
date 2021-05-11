import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Class for handling theme changes like language and  theme color

class ThemeChangeHandler {
  /// Function that changes the language by using the easy localization package
  /// Easy localization uses context of parent widget
  /// selectionsLanguage two entry array if first entry is true app shows in german,
  /// if second entry is true app shows in english
  void setLanguage(int index, BuildContext context) {
    for (int buttonIndex = 0;
        buttonIndex < selectionsLanguage.length;
        buttonIndex++) {
      if (buttonIndex == index) {
        selectionsLanguage[buttonIndex] = true;
      } else {
        selectionsLanguage[buttonIndex] = false;
      }
    }
    if (selectionsLanguage[0]) {
      EasyLocalization.of(context).locale = Locale('de', 'DE');
      language = "de";
    } else {
      EasyLocalization.of(context).locale = Locale('en', 'US');
      language = "en";
    }
  }

  /// Function that changes the darkMode variable so dark mode turns on
  /// Here theme changer is used who uses the context of the widget who calls the changer
  void changeDarkMode(BuildContext context) {
    ThemeChanger themeChanger =
        Provider.of<ThemeChanger>(context, listen: false);
    darkMode
        ? themeChanger.setTheme(ThemeData.light().copyWith(
            primaryColor: primaryColor,
            accentColor: primaryColor,
            hintColor: Colors.grey,
          ))
        : themeChanger.setTheme(ThemeData.dark().copyWith(
            primaryColor: primaryColor,
            accentColor: primaryColor,
            hintColor: Colors.grey,
          ));
    darkMode = !darkMode;
  }

  /// Function that posts the value of the dark mode variable to the key value store at controller
  void setDarkModeUserConfig(bool value) async {
    String urlDarkModeExtension = "users/configs/darkMode";
    try {
      http.post(url + urlDarkModeExtension,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $jwtToken"
          },
          body: jsonEncode({
            "value": "$value",
          }));
    } on Exception {}
  }

  /// Function that posts the value of the language variable to the key value store at controller
  void setLanguageUserConfig(String isoCode) async {
    String urlLanguageExtension = "users/configs/language";
    try {
      http.post(url + urlLanguageExtension,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $jwtToken"
          },
          body: jsonEncode({
            "value": "$isoCode",
          }));
    } on Exception {}
  }
}
