import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ManageUser extends StatefulWidget {
  @override
  _ManageUserState createState() => _ManageUserState();
}

//Class for user management
class _ManageUserState extends State<ManageUser> {
  /// Strings for handle the user information
  String _newUsername = "";
  String _newPassword = "";
  String _confirmPassword = "";

  String nameExtension = 'users/me';
  String passwordExtension = 'users/password';

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MainAppbar(),
        drawer: MainDrawer(),
        body: Center(
          child: Container(
            width: 400,
            //Context will appear smaller on mobile devices
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
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
                  child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(120, 50)),
                    ),
                    onPressed: () {
                      _changeUsernameDialog();
                    },
                    child: Text(
                      "changeUsername".tr().toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                // This container contains a button which sends a request for the new password
                // of the user
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(120, 50)),
                    ),
                    onPressed: () {
                      _changePasswordDialog();
                    },
                    child: Text(
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

  _changeUsernameDialog() async {
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
                        _newUsername = value;
                      });
                    },
                  ),
                ),

                // This container contains a button which sends a request for the new username
                // of the user
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(120, 50)),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          try {
                            var _response = await http.post(url + nameExtension,
                                headers: {
                                  "Content-Type": "application/json",
                                  "Authorization": "Bearer $jwtToken"
                                },
                                body: json.encode({'username': _newUsername}));
                            if (_response.statusCode == 200) {
                              _forward();
                            } else {
                              _errorDialog();
                            }
                          } on Exception {
                            _errorDialog();
                          }
                        },
                        child: Text(
                          "change".tr().toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(120, 50)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "cancel".tr().toString(),
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                ),
              ],
            ));
  }

  _changePasswordDialog() async {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: SelectableText("changePassword".tr().toString()),
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
                        _newPassword = value;
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
                      labelText: "currentPassword".tr().toString(),
                    ),
                    onChanged: (String value) async {
                      setState(() {
                        _confirmPassword = value;
                      });
                    },
                  ),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(120, 50)),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          try {
                            var _response = await http.post(url + passwordExtension,
                                headers: {
                                  "Content-Type": "application/json",
                                  "Authorization": "Bearer $jwtToken"
                                },
                                body: json.encode({
                                  'new_password': _newPassword,
                                  'old_password': _confirmPassword
                                }));
                            if (_response.statusCode == 200) {
                              _forward();
                            } else {
                              _errorDialog();
                            }
                          } on Exception {
                            _errorDialog();
                          }
                        },
                        child: Text(
                          "change".tr().toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(120, 50)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "cancel".tr().toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }

  void _forward() {
    Navigator.pushReplacementNamed(context, "/login");
    permissions = [];
    jwtToken = "";
    adminAccess = false;
    userAccess = false;
  }

  void _errorDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          // Here are displayed all cliparts to put devices in different classes
          // At the end there ist a pop-up dialog to save or dismiss the changes
          return StatefulBuilder(builder: (context, setState) {
            return Center(
              child: Theme(
                data: ThemeData(
                  brightness: darkMode ? Brightness.dark : Brightness.light,
                  primaryColor: primaryColor,
                  accentColor: primaryColor,
                  hintColor: Colors.grey,
                ),
                child: AlertDialog(
                  scrollable: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  content: Container(
                    width: 300,
                    height: 140,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          alignment: Alignment.center,
                          child: SelectableText(
                            'wentWrongError'.tr().toString(),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Ok"))
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
}
