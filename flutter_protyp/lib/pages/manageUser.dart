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
  /// Strings for handle the userinformation
  String _username = "mustermann";
  String _password = "asdfasdf";
  String _newUsername = "";
  String _newPassword = "";
  String _confirmPassword = "";

  String nameExtension = 'users/me';
  String passwordExtension = 'users/password';

  /// Var for saving the brightness state of the device
  var response;

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
                      _changeUsernameDialog(context);
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
                  child: RaisedButton(
                    onPressed: () {
                      _changePasswordDialog(context);
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

  _changeUsernameDialog(BuildContext context) async {
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
                        _confirmPassword = value;
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
                      RaisedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          print(jwtToken);
                          response = await http.post(url + nameExtension,
                              headers: {
                                "Content-Type": "application/json",
                                "Authorization": "Bearer $jwtToken"
                              },
                              body: json.encode({'username': _newUsername}));

                          print(response.body);
                          print(response.statusCode);
                        },
                        child: Text(
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

  _changePasswordDialog(BuildContext context) async {
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
                  height: mobileDevice ? 45 : 60,
                  width: 100,
                  alignment: Alignment.center,
                  child: SelectableText(
                    "minCharacters".tr().toString(),
                    style: TextStyle(color: Colors.red[700], fontSize: 20),
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
                      RaisedButton(
                        onPressed: () async {
                          response = await http.post(url + passwordExtension,
                              headers: {
                                "Content-Type": "application/json",
                                "Authorization": "Bearer $jwtToken"
                              },
                              body: json.encode({
                                'old_password': _password,
                                'new_password': _newPassword
                              }));

                          print(response.body);
                          print(response.statusCode);

                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "change".tr().toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      RaisedButton(
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
}
