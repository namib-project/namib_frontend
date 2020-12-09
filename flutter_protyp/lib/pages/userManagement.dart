import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/widgets/appbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserManagement extends StatefulWidget {
  @override
  _UserManagementState createState() => _UserManagementState();
}

//Class for user management
class _UserManagementState extends State<UserManagement> {
  ///
  String username = "mustermann";
  String password = "asdfasdf";
  String newUsername = "";
  String newPassword = "";
  String confirmPassword = "";
  bool error1 = false;
  bool error2 = false;

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MainAppbar(),
        drawer: MainDrawer(),
        body: Center(
          child: Container(
            width: mobileDevice ? 300 : 400,
            //Context will appear smaller on mobile devices
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Text(
                    "Benutzer verwalten",
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
                  child: RaisedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                                contentPadding: EdgeInsets.all(20.0),
                                children: <Widget>[
                                  Container(
                                    height: 70,
                                    alignment: Alignment.center,
                                    child: TextField(
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Neuer Benutzername",
                                      ),
                                      onChanged: (String value) async {
                                        setState(() {
                                          newUsername = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 70,
                                    alignment: Alignment.center,
                                    child: TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Passwort",
                                      ),
                                      onChanged: (String value) async {
                                        setState(() {
                                          confirmPassword = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 70,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        RaisedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Ändern"),
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Abbrechen"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                    },
                    child: Text("Benutzername ändern",
                    style: TextStyle(fontSize: 20),),
                  ),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: RaisedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                            contentPadding: EdgeInsets.all(20.0),
                            children: <Widget>[
                              Container(
                                height: 70,
                                alignment: Alignment.center,
                                child: TextField(
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Neues Passwort",
                                  ),
                                  onChanged: (String value) async {
                                    setState(() {
                                      newPassword = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                height: 70,
                                alignment: Alignment.center,
                                child: TextField(
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Bisheriges Passwort",
                                  ),
                                  onChanged: (String value) async {
                                    setState(() {
                                      confirmPassword = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                height: 70,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    RaisedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Ändern"),
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Abbrechen"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    },
                    child: Text("Passwort ändern",
                      style: TextStyle(fontSize: 20),),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
