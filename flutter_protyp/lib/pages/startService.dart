import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/loginTest.dart';
import 'package:flutter_protyp/pages/registrationStart.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'handlers/ThemeHandler.dart';

class StartService extends StatefulWidget {
  @override
  _StartServiceState createState() => _StartServiceState();
}

class _StartServiceState extends State<StartService> {
  Future<String> setupData;

  ThemeChangeHandler themeChangeHandler = new ThemeChangeHandler();
  List<Locale> systemLocale = WidgetsBinding.instance.window.locales;

  void setLanguage() {
    Locale language;
    setState(() {
      language = systemLocale.first;
    });

    if (language.toString() == "de_DE") {
      setState(() {
        themeChangeHandler.setLanguage(0, context);
        selectionsLanguage = [true, false];
      });
    } else {
      setState(() {
        themeChangeHandler.setLanguage(1, context);
        selectionsLanguage = [false, true];
      });
    }
  }

  Future<String> fetchSetup() async {
    //try {
     //String url = "http:://192.26.144.1/status";
     //var response = await http.get(url);
     //if (response.statusCode == 200) {
     //  return response.body;
     // }
    //} on Exception {
      return '{"setup_required":false,"version":"master_238571de23"}'; //TODO real exception catch by release
    //}
  }

  @override
  void initState() {
    super.initState();
    setupData = fetchSetup();
  }

  @override
  Widget build(BuildContext context) {
    setLanguage();
    return FutureBuilder<String>(
      future: setupData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data = jsonDecode(snapshot.data);
          bool required_setup = data["setup_required"];
          if (required_setup) {
            return RegistrationStart();
          } else {
            return LoginTest();
          }
        } else if (snapshot.hasError) {
          return LoginTest();
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
