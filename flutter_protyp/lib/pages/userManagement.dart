import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/user.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/pages/usersTable.dart';
import 'package:http/http.dart' as http;

// This class is for the administrator to delete or put a role to a user

class UserManagement extends StatefulWidget {
  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  /// List with all registered users
  Future<List<User>> users;

  String newPassword = "";
  String newUsername = "";
  List<dynamic> roleIds = [];
  int userID = 1;

  @override
  void initState() {
    super.initState();
    //getUsers();
    //getSpecificUser();
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
                            ElevatedButton(
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

  // This method reopens the side after editing changes
  void saveChanges() {
    Navigator.pushReplacementNamed(context, "/userManagement");
  }

  void forwarding() {
    Navigator.pushReplacementNamed(context, "/userManagement");
  }

  void deleteUser(User user) {
    Navigator.pushReplacementNamed(context, "/userManagement");
  }


  // TODO: Embedding the userhandling
// Function to get the users-list from controller
  Future<List<User>> getUsers() async {
    String usersExtension = 'management/users/';
    var _response = await http.get(url + usersExtension,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        }).timeout(const Duration(seconds: 5), onTimeout: () {
      return _handleTimeOut();
    });
    if (_response.statusCode == 200) {
      String _data = utf8.decode(_response.bodyBytes);
      print(json.decode(_data));

      var jdecode = jsonDecode(_data) as List;
      List<User> mudServObjs =
      jdecode.map((tagJson) => User.fromJson(tagJson)).toList();
      return mudServObjs;
    } else {
      throw Exception("Failed to get Data");
    }
  }

  void createUser() async {
    String createusersExtension = 'management/users';
    var _responseCreate = await http.post(url + createusersExtension,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        },
        body: json.encode({
          'password': newPassword,
          'roles_ids': roleIds,
          'username': newUsername
        }
        )
    );
  }


 //void getSpecificUser() async {
 //  String specificUserEExtension = 'management/users/{$userID}';
 //  var _responseSpecificUser = await http.get(url + specificUserEExtension,
 //      headers: {
 //        "Content-Type": "application/json",
 //        "Authorization": "Bearer $jwtToken"
 //      }).timeout(const Duration(seconds: 5), onTimeout: () {
 //        return _handleTimeOut();
 //      },
 //  );
 //  print(json.decode(_responseSpecificUser.body));
 //}


  dynamic _handleTimeOut() {}
}