import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/about.dart';
import 'package:flutter_protyp/pages/administrativeSettings.dart';
import "package:flutter_protyp/pages/deviceOverview.dart";
import 'package:flutter_protyp/pages/dummy.dart';
import 'package:flutter_protyp/pages/editRoomBuilder.dart';
import 'package:flutter_protyp/pages/ignoredDeviceBuilder.dart';
import "package:flutter_protyp/pages/newDeviceBuilder.dart";
import 'package:flutter_protyp/pages/registration.dart';
import 'package:flutter_protyp/pages/startService.dart';
import 'package:flutter_protyp/pages/manageUser.dart';
import 'package:flutter_protyp/pages/userManagementBuilder.dart';
import 'package:flutter_protyp/pages/enforcerBuilder.dart';
import 'package:flutter_protyp/widgets/theme.dart';
import 'package:provider/provider.dart';
import "package:flutter_protyp/widgets/constant.dart";
import "package:flutter_protyp/pages/login.dart";
import 'package:flutter_protyp/pages/registrationStart.dart';

/// Runs at start of application
/// Runs MyApp which is wrapped by EasyLocalization for language support
void main() => runApp(
      EasyLocalization(
        child: MyApp(),
        path: "resources/langs",
        saveLocale: true,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('de', 'DE'),
        ],
      ),
    );

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
        create: (_) => ThemeChanger(ThemeData.light().copyWith(
          primaryColor: primaryColor,
          accentColor: primaryColor,
          hintColor: Colors.grey,
        )),
        child: new MaterialAppWithTheme(),
      ),
    );
  }
}

/// assigns every link a widget for different sites
/// has [theme] for theme Support on every site
class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      title: "NAMIB Controller",
      theme: theme.getTheme(),
      initialRoute: "/startService",
      routes: {
        "/startService": (context) => StartService(),
        "/login": (context) => Login(),
        "/deviceOverview": (context) => DeviceOverview(),
        "/registration": (context) => Registration(),
        "/manageUser": (context) => ManageUser(),
        "/registrationStart": (context) => RegistrationStart(),
        "/about": (context) => About(),
        "/userManagement": (context) => UserManagement(),
        "/newDeviceOverview": (context) => NewDeviceOverview(),
        "/ignoredDeviceOverview": (context) => IgnoredDeviceOverview(),
        "/editRoom": (context) => EditRoom(),
        "/enforcerBuilder": (context) => EnforcerBuilder(),
        "/dummie": (context) => Dummy(),
        "/administrativeSettings": (context) => AdministrativeSettings()
      },
    );
  }
}
