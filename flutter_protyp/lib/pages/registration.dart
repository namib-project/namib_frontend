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
  bool errorMessage = false;

  void _handlePasswordInput() {}

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MainAppbar(),
        drawer: MainDrawer(),
        body: Center(
          child: Container(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 60,
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
                  height: 60,
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Benutzername"),
                  ),
                ),
                Container(
                  height: 60,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Passwort"),
                    onChanged: (String value) async {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                ),
                Container(
                  height: 60,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Passwort wiederholen"),
                    onChanged: (String value) async {
                      await Future.delayed(const Duration(seconds: 1), () {
                        if (value != password) {
                          setState(() {
                            errorMessage = true;
                          });
                        } else {
                          setState(() {
                            errorMessage = false;
                          });
                        }
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: errorMessage,
                  child: Container(
                      height: 60,
                      child: Text(
                        "Die eingegebenen Passwörter stimmen nicht überein",
                        style: TextStyle(color: Colors.red[700], fontSize: 20),
                      )),
                ),
                Container(
                  height: 60,
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
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.grey,
                        child: Text(
                          "Abbrechen",
                          style: TextStyle(fontSize: 20),
                        ),
                        padding: EdgeInsets.all(15),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
