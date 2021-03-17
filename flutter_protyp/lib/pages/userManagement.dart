import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/user.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/pages/usersTable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class UserManagement extends StatefulWidget {
  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder<List<User>>(
                future: users,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: UsersTable(users: snapshot.data),
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Container(
                      width: 600,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SelectableText("wentWrongError".tr().toString()),
                            RaisedButton(
                                child: Text("reload".tr().toString()),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "/userManagement");
                                })
                          ]),
                    );
                  } else {
                    return SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
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

Future<List<User>> getUsers() async {
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
