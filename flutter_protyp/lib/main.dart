import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/about.dart';
import 'package:flutter_protyp/pages/deviceDetails.dart';
import "package:flutter_protyp/pages/login.dart";
import "package:flutter_protyp/pages/deviceOverview.dart";
import "package:flutter_protyp/pages/createDevice.dart";
import "package:flutter_protyp/pages/networkbehaviour.dart";
import "package:flutter_protyp/pages/createMudProfile.dart";
import 'package:flutter_protyp/pages/ownUser.dart';
import 'package:flutter_protyp/pages/registration.dart';
import 'package:flutter_protyp/pages/startService.dart';
import 'package:flutter_protyp/pages/manageUser.dart';
import 'package:flutter_protyp/pages/userManagement.dart';
import 'package:flutter_protyp/widgets/theme.dart';
import 'package:provider/provider.dart';
import "package:flutter_protyp/widgets/constant.dart";

import "package:flutter_protyp/pages/languagetest.dart";
import "package:flutter_protyp/pages/editDevice.dart";

import "package:flutter_protyp/pages/loginTest.dart";
import 'package:flutter_protyp/pages/registrationStart.dart';

/// Runs at start of application
/// Runs MyApp which is wrapped by EasyLocalization for language support
void main() => runApp(EasyLocalization(
      child: MyApp(),
      path: "resources/langs",
      saveLocale: true,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
    ));

/// returns MaterialAppWithTheme which is wrapped by ChangeNotifierProvider
/// for dark light Theme support on every site
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: ChangeNotifierProvider<ThemeChanger>(
          builder: (_) => ThemeChanger(ThemeData.light().copyWith(
            primaryColor: primaryColor,
            accentColor: primaryColor,
            hintColor: Colors.grey,
          )),
          child: new MaterialAppWithTheme(),
        ));
  }
}

/// assigns every link a widget for different sites
/// has [theme] for theme Support on every site
class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
        theme: theme.getTheme(),
        initialRoute: "/startService",
        routes: {
          "/login": (context) => Login(),
          "/startService": (context) => StartService(),
          "/loginTest": (context) => LoginTest(),
          "/deviceOverview": (context) => DeviceOverview(),
          "/createDevice": (context) => CreateDevice(),
          "/networkbehaviour": (context) => Networkbehaviour(),
          "/createMudProfile": (context) => CreateMudProfile(),
          "/editDevice": (context) => EditDevice(),
          "/registration": (context) => Registration(),
          "/manageUser": (context) => ManageUser(),
          "/ownUser": (context) => OwnUser(),
          "/registrationStart": (context) => RegistrationStart(),
          "/deviceDetails": (context) => DeviceDetails(),
          "/about": (context) => About(),
          "/userManagement": (context) => UserManagement(),
          "/languagetest": (context) =>
              LanguageTest(), // just for testing can be deleted
        });
  }
}
