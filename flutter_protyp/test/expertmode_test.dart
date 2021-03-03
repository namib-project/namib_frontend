import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_protyp/pages/settings.dart';
import 'package:flutter_protyp/widgets/constant.dart';


void themeTest() {
  /// tests the setTheme function in theme.dart
  test("Test with all possible values for set Expertmode", () {
    Settings s = new Settings();
    Constant c = new Constant();


    //ThemeChanger themeChanger = new ThemeChanger(ThemeData.light());
    //themeChanger.setTheme(ThemeData.dark());
    //expect(themeChanger.getTheme(), ThemeData.dark());

  });
}
