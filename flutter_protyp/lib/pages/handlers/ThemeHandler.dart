import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/theme.dart';
import 'package:provider/provider.dart';

// Class for handling theme changes like language, theme color and expert mode

class ThemeChangeHandler {
  // Function that changes the language by using the easy localization package
  // Easy localization uses context of parent widget
  // selectionsLanguage two entry array if first entry is true app shows in german,
  // if second entry is true app shows in english
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

  // Function that changes the darkMode variable so dark mode turns on
  // Here theme changer is used who uses the context of the widget who calls the changer
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

  // Function that changes the apps appearance by the given value
  // If true all Visibility widget depending on this expert mode variable are shown
  void changeExpertMode(bool value, BuildContext context) {
    expertMode = value;
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    !darkMode
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
  }
}
