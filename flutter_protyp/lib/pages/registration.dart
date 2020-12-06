import 'dart:io';

import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/widgets/appbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String password = "";
  bool errorMessage1 = false;
  bool errorMessage2 = false;
  bool passwordMessage = false;

  void _handlePasswordInput() {}

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MainAppbar(),
        drawer: MainDrawer(),
        body: Center(
          child: Container(
            width: mobileDevice ? 300 : 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Text(
                    "Registrieren",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Benutzername"),
                  ),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Passwort"),
                    onChanged: (String value) async {
                      setState(() {
                        password = value;
                      });
                      await Future.delayed(const Duration(seconds: 1), () {
                        if (value.length < 8) {
                          setState(() {
                            errorMessage1 = true;
                          });
                        } else {
                          setState(() {
                            errorMessage1 = false;
                          });
                        }
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: errorMessage1,
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: Text(
                      "Das Passwort muss mindestens 8 Zeichen haben",
                      style: TextStyle(color: Colors.red[700], fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Passwort wiederholen"),
                    onChanged: (String value) async {
                      await Future.delayed(const Duration(seconds: 1), () {
                        if (value != password) {
                          setState(() {
                            errorMessage2 = true;
                            passwordMessage = false;
                          });
                        } else {
                          setState(() {
                            errorMessage2 = false;
                            passwordMessage = true;
                          });
                        }
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: errorMessage2,
                  child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: Text(
                        "Die eingegebenen Passwörter stimmen nicht überein",
                        style: TextStyle(color: Colors.red[700], fontSize: 20),
                      )),
                ),
                Visibility(
                  visible: passwordMessage,
                  child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: Text(
                        "Das Passwort ist lang genug und stimmt überein",
                        style: TextStyle(color: Colors.green[700], fontSize: 20),
                      )),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.blue[600],
                        child: Text(
                          "Registrieren",
                          style: TextStyle(fontSize: 20),
                        ),
                        padding: EdgeInsets.all(15),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
