import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/deviceOverview.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:http/http.dart' as http;
import 'dummie.dart';
import 'handlers/ThemeHandler.dart';

// Class that gets the config variables after successful login,
// alters theme if necessary

class ThemingService extends StatefulWidget {
  const ThemingService({
    Key key,
    @required this.brightness,
  }) : super(key: key);
  final String brightness;

  _ThemingServiceState createState() => _ThemingServiceState();
}

class _ThemingServiceState extends State<ThemingService> {
  /// Variables that are expected from controller
  Future<String> configLanguage;
  Future<bool> configDarkMode;
  Future<bool> configExpertMode;

  // Init function that calls functions for requesting data from controller
  @override
  void initState() {
    super.initState();
    configDarkMode = _getDarkModeUserConfig();
    configExpertMode = _getExpertModeUsersConfig();
    configLanguage = _getLanguageUsersConfig();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: configLanguage,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(adminAccess == false && userAccess == false){
              return Dummie();
            }else{
              return DeviceOverview();
            }
          } else if (snapshot.hasError) {
            return DeviceOverview();
          } else {
            return SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  /// ThemeChangeHandler offers functions for changing theme
  ThemeChangeHandler themeChangeHandler = new ThemeChangeHandler();

  // Function try to fetch data for setting dark mode from controller
  Future<bool> _getDarkModeUserConfig() async {
    String urlExtension = "users/configs/darkMode";

    try {
      var response = await http.get(url + urlExtension, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwtToken"
      });

      // If request is successful theme gets alter if necessary, if request is
      // not successful setTheme() set theme color like OS properties
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["value"] == "true") {
          darkMode = false;
          themeChangeHandler.changeDarkMode(context);
        }
      } else {
        setTheme();
      }
    } on Exception {
      setTheme();
    }
    return darkMode;
  }

  // This method sets the brightness-theme for the app from properties of the operating system
  void setTheme() {
    if (widget.brightness.toString() != "Brightness.light" &&
        darkMode == false) {
      setState(() {
        themeChangeHandler.changeDarkMode(context);
      });
    }
  }

  // Function try to fetch data for setting the language from controller
  Future<String> _getLanguageUsersConfig() async {
    String urlExtension = "users/configs/language";
    try {
      var response = await http.get(url + urlExtension, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwtToken"
      });

      // If request is successful language gets alter if necessary, if request is
      // not successful nothing happens because app language is already like OS language
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["value"] != language &&
            language == "en") {
          themeChangeHandler.setLanguage(1, context);
        } else if (jsonDecode(response.body)["value"] != language &&
            language == "de") {
          themeChangeHandler.setLanguage(0, context);
        }
        return response.body;
      } else {
        return language;
      }
    } on Exception {
      return language;
    }
  }

  // Function try to fetch data for setting the expert mode from controller
  Future<bool> _getExpertModeUsersConfig() async {
    String urlExtension = "users/config/expertMode";
    try {
      // If request is successful expert mode gets alter if necessary, if request is
      // not successful nothing happens because expert mode is off by default
      var response = await http.get(url + urlExtension, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwtToken"
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["value"] == "true") {
          themeChangeHandler.changeExpertMode(true, context);
        }
        return true;
      } else {
        return expertMode;
      }
    } on Exception {
      return expertMode;
    }
  }
}
