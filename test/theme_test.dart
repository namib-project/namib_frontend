import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_protyp/widgets/theme.dart';

void themeTest() {
  /// tests the setTheme function in theme.dart
  test("Test with all possible values for setTheme", () {

    ///1. create light
    ///2. set dark
    ///3. expect dark
    ThemeChanger themeChanger = new ThemeChanger(ThemeData.light());
    themeChanger.setTheme(ThemeData.dark());
    expect(themeChanger.getTheme(), ThemeData.dark());

    ///1. create dark
    ///2. set light
    ///3. expect light
    ThemeChanger themeChanger1 = new ThemeChanger(ThemeData.dark());
    themeChanger1.setTheme(ThemeData.light());
    expect(themeChanger1.getTheme(), ThemeData.light());

    ///1. create light
    ///2. set light
    ///3. expect light
    ThemeChanger themeChanger2 = new ThemeChanger(ThemeData.light());
    themeChanger2.setTheme(ThemeData.light());
    expect(themeChanger2.getTheme(), ThemeData.light());

    ///1. create dark
    ///2. set dark
    ///3. expect dark
    ThemeChanger themeChanger3 = new ThemeChanger(ThemeData.dark());
    themeChanger3.setTheme(ThemeData.dark());
    expect(themeChanger3.getTheme(), ThemeData.dark());

   //-- Testing if init value is working itself --- //
    ///1. create light
    ///2. expect light
    ThemeChanger themeChanger4 = new ThemeChanger(ThemeData.light());
    expect(themeChanger.getTheme(), ThemeData.light());

   ///1. create dark
    ///2. expect dark
    ThemeChanger themeChanger5 = new ThemeChanger(ThemeData.dark());
    expect(themeChanger.getTheme(), ThemeData.dark());


  });
}
