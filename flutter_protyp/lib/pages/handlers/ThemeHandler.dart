import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/theme.dart';
import 'package:provider/provider.dart';

class ThemeChangeHandler {
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
    } else {
      EasyLocalization.of(context).locale = Locale('en', 'US');
    }
  }

  void changeDarkMode(BuildContext context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
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
}
