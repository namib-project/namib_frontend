import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/user.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class UserManagement extends StatefulWidget {
  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  Future<List<User>> users;

  Future<List<User>> fetchUsers() async {
    //String usersExtension = "users";
    //response = await http.get(url + usersExtension, headers: {
    //  "Content-Type": "application/json",
    //  "Authorization": "Bearer $jwtToken"
    //});
    //return response.body;
    String test =
        '[{"username":"manfred", "admin":true, "user": true},{"username":"gertrud", "admin":false, "user":true}]';
    var jdecode = jsonDecode(test) as List;
    List<User> mudServObjs =
        jdecode.map((tagJson) => User.fromJson(tagJson)).toList();
    return mudServObjs;
  }

  @override
  void initState() {
    super.initState();
    users = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Container(
              height: 70,
              alignment: Alignment.center,
              child: SelectableText(
                'userManagement'.tr().toString(),
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // This table row displays all users who have an account at the controller
            Row(children: [
              Expanded(flex: 1, child: Container()),
              _userTable(),
              Expanded(flex: 1, child: Container())
            ])
          ],
        ),
      ),
    );
  }

  Expanded _userTable() {
    return Expanded(
        flex: 16,
        child: FutureBuilder<List<User>>(
            future: users,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DataTable(
                  columns: [
                    DataColumn(
                      label: SelectableText("username".tr().toString()),
                    ),
                    DataColumn(
                      label: SelectableText("edit".tr().toString()),
                    ),
                    DataColumn(
                      label: SelectableText("delete".tr().toString()),
                    ),
                  ],
                  rows: snapshot.data
                      .map((user) => DataRow(cells: [
                            DataCell(SelectableText(user.username)),
                            DataCell(IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () {
                                _editUserRoleDialog(context, user);
                              },
                            )),
                            DataCell(IconButton(
                              onPressed: () {
                                _deleteUserDialog(context, user, snapshot);
                              },
                              icon: Icon(Icons.delete),
                            ))
                          ]))
                      .toList(),
                );
              } else if (snapshot.hasError) {
                return Column(
                  children: [
                    SelectableText("wentWrongError".tr().toString()),
                    FlatButton(
                        color: primaryColor,
                        onPressed: () {
                          forwarding();
                        },
                        child: Text("reload".tr().toString()))
                  ],
                );
              }
              return SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator());
            }));
  }

  void _deleteUserDialog(
      BuildContext context, User user, AsyncSnapshot<List<User>> snapshot) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Theme(
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
              title: SelectableText("delete".tr().toString() + "?"),
              content: SelectableText(user.username),
              actions: [
                SizedBox(
                  width: 100,
                  height: 30,
                  child: RaisedButton(
                    onPressed: () {
                      deleteUser(user);
                      snapshot.data.remove(user);
                      Navigator.of(context).pop(); // dismiss dialog
                    },
                    child: Text(
                      "confirmation".tr().toString(),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  void _editUserRoleDialog(BuildContext context, User user) {
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
                    height: 280,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 70,
                          alignment: Alignment.center,
                          child: SelectableText(
                            'edit'.tr().toString(),
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SelectableText(user.username,
                            style: TextStyle(fontSize: 25)),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SelectableText("roles".tr().toString() + ":"),
                            Row(
                              children: [
                                SelectableText("Admin"),
                                Checkbox(
                                  activeColor: buttonColor,
                                  value: user.admin,
                                  onChanged: (bool value) {
                                    setState(() {
                                      user.admin = value;
                                    });
                                  },
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SelectableText("user".tr().toString()),
                                Checkbox(
                                    activeColor: buttonColor,
                                    value: user.user,
                                    onChanged: (bool value) {
                                      setState(() {
                                        user.user = value;
                                      }); //TODO erst übernehmen wenn save drücken
                                    })
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Buttons to accept or dismiss the changes like discribed above
                            FlatButton(
                              child: Text(
                                "cancel".tr().toString(),
                                style: TextStyle(
                                  color: buttonColor,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(); // dismiss dialog
                              },
                            ),
                            FlatButton(
                              child: Text(
                                "save".tr().toString(),
                                style: TextStyle(
                                  color: buttonColor,
                                ),
                              ),
                              onPressed: () {
                                //TODO http request to update roles of user
                                Navigator.of(context).pop(); // dismiss dialog
                                saveChanges();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  void saveChanges() {
    Navigator.pushReplacementNamed(context, "/userManagement");
  }

  void forwarding() {
    Navigator.pushReplacementNamed(context, "/userManagement");
  }

  void deleteUser(User user) {
    Navigator.pushReplacementNamed(context, "/userManagement");
  }
}
