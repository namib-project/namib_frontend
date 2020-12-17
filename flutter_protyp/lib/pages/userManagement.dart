import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:easy_localization/easy_localization.dart';

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

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MainAppbar(),
        drawer: MainDrawer(),
        body: Center(
          child: Container(
            width: 400,
            //Context will appear smaller on mobile devices
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: SelectableText(
                    'manageUser'.tr().toString(),
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
                            title: SelectableText('changeUsername'.tr().toString()),
                                contentPadding: EdgeInsets.all(20.0),
                                children: <Widget>[
                                  Container(
                                    height: 70,
                                    alignment: Alignment.center,
                                    child: TextField(
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "newUsername".tr().toString(),
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
                                        labelText: "password".tr().toString(),
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
                                          child: Text (
                                            "change".tr().toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text (
                                            "cancel".tr().toString(),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                    },
                    child: Text (
                      "changeUsername".tr().toString(),
                      style: TextStyle(fontSize: 20),
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
                                title: SelectableText ("changePassword".tr().toString()),
                                contentPadding: EdgeInsets.all(20.0),
                                children: <Widget>[
                                  Container(
                                    height: 70,
                                    alignment: Alignment.center,
                                    child: TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "newPassword".tr().toString(),
                                      ),
                                      onChanged: (String value) async {
                                        setState(() {
                                          newPassword = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: mobileDevice ? 45 : 60,
                                    width: 100,
                                    alignment: Alignment.center,
                                    child: SelectableText (
                                      "minCharacters".tr().toString(),
                                      style: TextStyle(
                                          color: Colors.red[700], fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    height: 70,
                                    alignment: Alignment.center,
                                    child: TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "currentPassword".tr().toString(),
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
                                          child: Text (
                                            "change".tr().toString(),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text (
                                            "cancel".tr().toString(),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                    },
                    child: Text (
                      "changePassword".tr().toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
