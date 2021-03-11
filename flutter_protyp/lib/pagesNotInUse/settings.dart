import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:provider/provider.dart';
import 'package:flutter_protyp/widgets/theme.dart';
import 'package:easy_localization/easy_localization.dart';

/// /settings
/// The site for the states/settings of the entire software, such as language and mode.
class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);

    return new Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'settings'.tr().toString(),
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /// Description of the settings-site.
                /// Note: This will be changed to a hovered explanation.
                ExpansionTile(
                  title: Text("Beschreibung",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                      )),
                  children: <Widget>[
                    Text(
                      "Dark mode: Wählen aus für Dark mode",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Expertenmodus: Wählen aus für Expertenmodus",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Sprache: Wählen Sie die gewünschte Sprache",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                /// Switch to change the Dark / LightMode
                Container(
                  alignment: Alignment.centerLeft,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dark mode",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Switch(
                        value: darkMode,
                        activeColor: buttonColor,
                        onChanged: (bool s) {
                          setState(() {
                            darkMode
                                ? themeChanger
                                    .setTheme(ThemeData.light().copyWith(
                                    primaryColor: primaryColor,
                                    accentColor: primaryColor,
                                    hintColor: Colors.grey,
                                  ))
                                : themeChanger
                                    .setTheme(ThemeData.dark().copyWith(
                                    primaryColor: primaryColor,
                                    accentColor: primaryColor,
                                    hintColor: Colors.grey,
                                  ));
                            darkMode = !darkMode;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                /// Switch to change ExpertMode
                Container(
                  alignment: Alignment.centerLeft,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'expertMode'.tr().toString(),
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Switch(
                        value: expertMode,
                        activeColor: buttonColor,
                        onChanged: (bool s) {
                          setState(() {
                            expertMode = s;
                            
                          });
                        },
                      )
                    ],
                  ),
                ),

                /// Saving the variable of the language and deciding whether the application is shown in German or English.
                /// The entire translation is handled in flutter_prototyp/resources/langs/[de-DE.json / en-US.json]
                Container(
                  alignment: Alignment.centerLeft,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'language'.tr().toString(),
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          // set german language
                          setState(() {
                            EasyLocalization.of(context).locale =
                                Locale('de', 'DE');
                          });
                        },
                        child: Text('german'.tr().toString()),
                      ),
                      FlatButton(
                        onPressed: () {
                          // set english language
                          setState(() {
                            EasyLocalization.of(context).locale =
                                Locale('en', 'US');
                          });
                        },
                        child: Text('english'.tr().toString()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}