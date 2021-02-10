import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/user.dart';
import 'package:flutter_protyp/pages/deviceDetails.dart';
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
  bool admin = false;
  bool userRights = false;

  Future<List<User>> fetchUsers() async {
    //String url = "http://172.26.144.1:8000/users";
    //response = await http.get(url, headers: {
    //  "Content-Type": "application/json",
    //  "Authorization": "Bearer $jwtToken"
    //});
    //return response.body;
    String test =
        '[{"username":"manfred", "admin":true},{"username":"gertrud", "admin":false}]';
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
              Expanded(
                  flex: 16,
                  child: FutureBuilder<List<User>>(
                      future: users,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DataTable(
                            columns: [
                              DataColumn(
                                label:
                                    SelectableText("username".tr().toString()),
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
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                // Here are displayed all cliparts to put devieces in different classes
                                                // At the end there ist a pop-up dialog to save or dismiss the changes
                                                return StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return Theme(
                                                    data: ThemeData(
                                                      primaryColor:
                                                          primaryColor,
                                                      accentColor: primaryColor,
                                                      hintColor: Colors.grey,
                                                    ),
                                                    child: Center(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: AlertDialog(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18.0),
                                                          ),
                                                          content: Container(
                                                            width: 300,
                                                            height: 490,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  height: 70,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      SelectableText(
                                                                    'edit'
                                                                        .tr()
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "OpenSans",
                                                                      fontSize:
                                                                          30,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    SelectableText("roles"
                                                                            .tr()
                                                                            .toString() +
                                                                        ":"),
                                                                    Row(
                                                                      children: [
                                                                        SelectableText(
                                                                            "Admin"),
                                                                        Checkbox(
                                                                            value:
                                                                                admin,
                                                                            onChanged:
                                                                                (bool value) {
                                                                              setState(() {
                                                                                admin = value;
                                                                              });
                                                                            })
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SelectableText("user"
                                                                            .tr()
                                                                            .toString()),
                                                                        Checkbox(
                                                                            value:
                                                                                userRights,
                                                                            onChanged:
                                                                                (bool value) {
                                                                              setState(() {
                                                                                userRights = value;
                                                                              });
                                                                            })
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                Divider(
                                                                  height: 20,
                                                                ),
                                                                SizedBox(
                                                                  height: 22,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    // Buttons to accept or dismiss the changes like discribed above
                                                                    FlatButton(
                                                                      child:
                                                                          Text(
                                                                        "cancel"
                                                                            .tr()
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              buttonColor,
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(); // dismiss dialog
                                                                      },
                                                                    ),
                                                                    FlatButton(
                                                                      child:
                                                                          Text(
                                                                        "save"
                                                                            .tr()
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              buttonColor,
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        //TODO http request to update roles of user
                                                                            Navigator.pushReplacementNamed(context, "/userManagement");
                                                                            Navigator.of(context)
                                                                            .pop(); // dismiss dialog
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                });
                                              });
                                        },
                                      )),
                                      DataCell(IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: SelectableText(user.username),
                                                  content: SelectableText(
                                                      "confirm".tr().toString() + "?"),
                                                  actions: [
                                                    SizedBox(
                                                      width: 100,
                                                      height: 30,
                                                        child: RaisedButton(
                                                            onPressed: () {
                                                              deleteUser();
                                                              Navigator.of(context)
                                                                  .pop(); // dismiss dialog
                                                            },
                                                            child: Text("confirmation"
                                                                .tr()
                                                                .toString())))
                                                  ],
                                                );
                                              });
                                        },
                                        icon: Icon(Icons.delete),
                                      ))
                                    ]))
                                .toList(),
                          );
                        } else if (snapshot.hasError) {
                          return DeviceDetails(device: null);
                        }
                        return SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator());
                      })),
              Expanded(flex: 1, child: Container())
            ])
          ],
        ),
      ),
    );
  }

  void deleteUser() {
    Navigator.pushReplacementNamed(context, "/userManagement");
  }
}
