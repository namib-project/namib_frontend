import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";

import 'package:provider/provider.dart';
import 'package:flutter_protyp/widgets/theme.dart';

import 'package:easy_localization/easy_localization.dart';

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
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dark mode:",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    FlatButton(
                        child: Text('Dark'),
                        onPressed: () =>
                            themeChanger.setTheme(ThemeData.dark())),
                    FlatButton(
                        child: Text('Light'),
                        onPressed: () =>
                            themeChanger.setTheme(ThemeData.light())),
                  ],
                ),
              ),
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
                    FlatButton(
                      onPressed: () => {},
                      child: Text("Button"),
                    )
                  ],
                ),
              ),
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
    );
  }
}

/**
   FlatButton(
    child: Text('Dark Theme'),
    onPressed: () => _themeChanger.setTheme(ThemeData.dark())),
    FlatButton(
    child: Text('Light Theme'),
    onPressed: () => _themeChanger.setTheme(ThemeData.light())),
 */
