import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import "package:flutter_protyp/pages/login.dart";
import "package:flutter_protyp/pages/deviceOverview.dart";
import "package:flutter_protyp/pages/createDevice.dart";
import "package:flutter_protyp/pages/networkbehaviour.dart";
import "package:flutter_protyp/pages/createMudProfile.dart";
import "package:flutter_protyp/pages/settings.dart";
import 'package:flutter_protyp/widgets/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_protyp/pages/themetest.dart';

import "package:flutter_protyp/pages/languagetest.dart";
import "package:flutter_protyp/pages/test.dart";

void main() => runApp(EasyLocalization(
      child: MyApp(),
      path: "resources/langs",
      saveLocale: true,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
    ));

/**

      MaterialApp(
    initialRoute: "/login",
    routes: {
      //"/": (context) => Loading(),
      "/login": (context) => Login(),
      "/deviceOverview": (context) => DeviceOverview(),
      "/createDevice": (context) => CreateDevice(),
      "/networkbehaviour": (context) => Networkbehaviour(),
      "/createMudProfile": (context) => CreateMudProfile(),
      "/settings": (context) => Settings(),
    },
  )
  );
}
*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: ChangeNotifierProvider<ThemeChanger>(
          builder: (_) => ThemeChanger(ThemeData.light()),
          child: new MaterialAppWithTheme(),
        ));
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
        theme: theme.getTheme(),
        initialRoute: "/login",
        routes: {
          //"/": (context) => Loading(),
          "/login": (context) => Login(),
          "/deviceOverview": (context) => DeviceOverview(),
          "/createDevice": (context) => CreateDevice(),
          "/networkbehaviour": (context) => Networkbehaviour(),
          "/createMudProfile": (context) => CreateMudProfile(),
          "/settings": (context) => Settings(),
          "/test": (context) => Test(),
          "/languagetest": (context) =>
              LanguageTest(), // just for testing can be deleted
          "/test": (context) => Test(), // just for testing can be deleted
        });
  }
}
