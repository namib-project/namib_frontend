import 'dart:convert';
import 'package:flutter_protyp/data/roles.dart';
import 'package:flutter_protyp/pages/userManagement.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/user.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkable/constants.dart';
import 'package:http/http.dart' as http;

// This class builds the users-table to edit

class UsersTable extends StatefulWidget {
  UsersTable({
    Key key,
    @required this.users,
  }) : super(key: key);

  /// List which stores all given Users
  final List<User> users;

  UsersTableState createState() => UsersTableState();
}

class UsersTableState extends State<UsersTable> {
  List<User> _usersForDisplay = List<User>();
  bool _sortAscending = true;
  Icon _arrowUp = Icon(
    FontAwesomeIcons.arrowUp,
    size: 17,
  );
  Icon _arrowDown = Icon(
    FontAwesomeIcons.arrowDown,
    size: 17,
  );


  @override
  void initState() {
    setState(() {
      _usersForDisplay = widget.users;
      _sortUsersForDisplay();
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  child: SelectableText(
                    'Benutzer verwalten'.tr().toString(),
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 16,
                      child: (widget.users != null && widget.users.length != 0)
                          ? Column(
                              children: <Widget>[
                                TextButton(
                                  child: Text("newUser".tr().toString()),
                                  onPressed:() {
                                      _createUserDialog(context);
                                  },
                                ),
                                _searchBar(),
                                _listHeader(),

                                Container(
                                  height: 80.0 * _usersForDisplay.length,
                                  child: _listForUsers(context),
                                )
                              ],
                            )
                          : Container(
                              height: 80,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: SelectableText(
                                    "noEntries".tr().toString(),
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // This function sorts the users-table on button hit
  _listHeader() {
    return Container(
      height: 80,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          _sortAscending = !_sortAscending;
          _sortUsersForDisplay();
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: _sortAscending ? _arrowUp : _arrowDown,
                        ),
                        Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "Bearbeiten",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Löschen",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Here is a searchbar to search for users
  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Suche...",
          suffixIcon: Icon(
            FontAwesomeIcons.search,
          ),
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _usersForDisplay = widget.users.where((user) {
              var userName = user.username;
              return userName.contains(text);
            }).toList();
          });
          _sortUsersForDisplay();
        },
      ),
    );
  }

  // Here is the display-method for the users-table
  ListView _listForUsers(BuildContext context) {
    return ListView.builder(
      itemCount: _usersForDisplay.length,
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {},
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _usersForDisplay[index].username,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _editUserRoleDialog(context, _usersForDisplay[index]);
                        //get specific
                      },
                      icon: Icon(
                        FontAwesomeIcons.edit,
                        size: 17,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteUserDialog(context, _usersForDisplay[index]);


                      },
                      icon: Icon(
                        FontAwesomeIcons.trash,
                        size: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // This function sorts the devices-table by username
  _sortUsersForDisplay() {
    setState(() {
      if (_sortAscending) {
        _usersForDisplay.sort((a, b) => a.username.compareTo(b.username));
      } else {
        _usersForDisplay.sort((a, b) => b.username.compareTo(a.username));
      }
    });
  }

  // This dialog will appear, if you need to delete a user
  void _deleteUserDialog(BuildContext context, User user) {

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
              title: SelectableText("attention".tr().toString()),
              content: Container(
                height: 130,
                width: 300,
                child: Column(
                  children: [
                    SelectableText("deleteUserDisclaimer".tr().toString()),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Buttons to accept or dismiss the changes like described above
                        TextButton(
                          child: Text(
                            "Abbrechen",
                            style: TextStyle(
                              color: buttonColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(); // dismiss dialog
                          },
                        ),
                        TextButton(
                          child: Text(
                            "confirmation".tr().toString(),
                            style: TextStyle(
                              color: buttonColor,
                            ),
                          ),
                          onPressed: () {
                            _deleteUser(user);
                            Navigator.of(context).pop(); // dismiss dialog
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // This dialog will appear, if you need to edit a user-role
  void _editUserRoleDialog(BuildContext context, User user) {

    bool _admin = false;
    bool _user = false;

    if(user.roles != null )
      {
        for (Roles r in user.roles )
          {
            if(r.name == "admin"){
              _admin = true;
            }else if(r.name == "reader") {
              _user = true;
            }
          }
      }
      ;
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
                    height: 220,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 50,
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
                          height: 10,
                        ),
                        SelectableText(user.username,
                            style: TextStyle(fontSize: 25)),
                        SizedBox(
                          height: 20,
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
                                  value: _admin,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _admin = value;
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
                                    value: _user,
                                    onChanged: (bool value) {
                                      setState(() {
                                  _user = value;
                                      }); //TODO erst übernehmen wenn save drücken
                                    })
                              ],
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Buttons to accept or dismiss the changes like described above
                            TextButton(
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
                            TextButton(
                              child: Text(
                                "save".tr().toString(),
                                style: TextStyle(
                                  color: buttonColor,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(); // dismiss dialog
                                _saveChanges(user.user_id,_admin,_user, user);
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

  // This method is called after the changes are made
  void _saveChanges(int _userID, bool _admin, bool _user, User user ) async {
    Navigator.pushReplacementNamed(context, "/userManagement");
    int _roleID;

    int idtest = user.user_id;


    if (_admin == true ){
      _roleID = 0;
    }else if ( _user == true && _admin == false)
      {
        _roleID = 1;
      }

String rolesExtension = "roles/assign";

var _respopnseRoles = await http.post(url + rolesExtension,
    headers: {
    "Content-Type": "application/json",
    "Authorization": "Bearer $jwtToken"
    },
  body: json.encode( {
   'role_id': _roleID,
    'user_id': idtest
  })
  ).timeout(const Duration(seconds: 7),
    onTimeout: () {
      return _handleTimeOut();
    });

    print(_respopnseRoles.statusCode);
    print(_respopnseRoles.body);

  }

  // This method is called after the user was deleted
  void _deleteUser(User user) async {

    int userIDForRequest = user.user_id;

    String deleteUserExtension = 'management/users/$userIDForRequest';
    var _responseDelete = await http.delete(url + deleteUserExtension,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        },
    );
    Navigator.pushReplacementNamed(context, "/userManagement");
  }
}

  void _createUserDialog(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/registration");
  }

dynamic _handleTimeOut() {}
