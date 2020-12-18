import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/constant.dart';

class LanguageChangeHandler {
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
}
