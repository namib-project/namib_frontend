import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/login.dart';
import 'package:flutter_protyp/pages/registrationStart.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:http/http.dart' as http;

import 'handlers/ThemeChangeHandler.dart';

/// This class get the important information for building the application before the login appears

class StartService extends StatefulWidget {
  @override
  _StartServiceState createState() => _StartServiceState();
}

class _StartServiceState extends State<StartService> {
  /// Future element for delayed displaying
  Future<String> setupData;

  /// Vars for saving the settings from the operating system
  ThemeChangeHandler themeChangeHandler = new ThemeChangeHandler();
  List<Locale> systemLocale = WidgetsBinding.instance.window.locales;

  /// This method handles the language of the operating system
  void setLanguage() {
    Locale localeLanguage;
    setState(() {
      localeLanguage = systemLocale.first;
    });

    if (localeLanguage.toString() == "de_DE") {
      setState(() {
        themeChangeHandler.setLanguage(0, context);
        selectionsLanguage = [true, false];
      });
      language = "de";
    } else {
      setState(() {
        themeChangeHandler.setLanguage(1, context);
        selectionsLanguage = [false, true];
      });
      language = "en";
    }
  }

  /// Future string type to build at runtime
  /// Get request for the controller version to display it for the user
  Future<String> fetchSetup() async {
    try {
      String statusExtension = "status";
      var response = await http.get(Uri.parse(url + statusExtension));
      if (response.statusCode == 200) {
        String data = utf8.decode(response.bodyBytes);
        return data;
      } else {
        return '{"setup_required":false,"version":""}';
      }
    } on Exception {
      return '{"setup_required":false,"version":""}';
    }
  }

  @override
  void initState() {
    super.initState();
    setupData = fetchSetup();
  }

  @override
  Widget build(BuildContext context) {
    setLanguage();

    /// FutureBuilder widget, that will be build but context will be shown after get request above
    /// Here will be presented the current controller version
    return new Scaffold(
      body: Center(
        child: FutureBuilder<String>(
          future: setupData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = jsonDecode(snapshot.data);

              if (Uri.base.scheme != "https" && data["secure_name"] != null) {
                window.location.replace(Uri.base
                    .replace(
                        scheme: "https", host: data["secure_name"], port: 443)
                    .toString());
              }
              bool required_setup = data["setup_required"];
              if (required_setup) {
                return RegistrationStart();
              } else {
                return Login();
              }
            } else if (snapshot.hasError) {
              return Login();
            }

            /// By default, show a loading spinner.
            return SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
