import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_protyp/widgets/theme.dart';
import 'package:provider/provider.dart';

void themeTest() {
  test("Test with all possible values for setTheme", () {
    ThemeChanger(ThemeData.light());

    ThemeChanger themeChanger = new ThemeChanger(ThemeData.light());
    themeChanger.setTheme(ThemeData.dark());
    expect(themeChanger.getTheme(), ThemeData.dark());

    ThemeChanger themeChanger1 = new ThemeChanger(ThemeData.dark());
    themeChanger1.setTheme(ThemeData.light());
    expect(themeChanger1.getTheme(), ThemeData.light());

    ThemeChanger themeChanger2 = new ThemeChanger(ThemeData.light());
    themeChanger2.setTheme(ThemeData.light());
    expect(themeChanger2.getTheme(), ThemeData.light());

    ThemeChanger themeChanger3 = new ThemeChanger(ThemeData.dark());
    themeChanger3.setTheme(ThemeData.dark());
    expect(themeChanger3.getTheme(), ThemeData.dark());
  });
}
