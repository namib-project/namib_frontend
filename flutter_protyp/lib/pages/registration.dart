import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// This class is for the system-administrator to create a user

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  /// Variables for seeing the password
  bool seePassword1 = false;
  bool seePassword2 = false;
  Icon iconSee = Icon(
    FontAwesomeIcons.eyeSlash,
    size: 20,
  );
  Icon iconDontSee = Icon(
    FontAwesomeIcons.eye,
    size: 20,
  );

  ///Variables for user inputs
  String _password = "";
  String _username = "";
  String _secPassword = "";

  ///Variables for visibility of error messages
  bool errorMessage1 = false;
  bool errorMessage2 = false;
  bool passwordMessage = false;
  bool regisButton = false;
  bool usernameMessage = false;
  bool networkMessage = false;

  ///Test for http client
  String signupExtension = "management/users/";

  /// Stores the response from the controller
  var response;

  /// To give roles to the new user
  bool _admin = false;
  bool _user = false;
  List _roleID = [];

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: SelectableText(
                          "newUser".tr().toString(),
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: TextField(
                          obscureText: false,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "username".tr().toString(),
                          ),
                          onChanged: (String value) async {
                            setState(() {
                              _username = value;
                            });
                            _checkForRegistrationButton();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: TextField(
                          cursorColor: Colors.grey,
                          obscureText: !seePassword1,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "password".tr().toString(),
                            suffixIcon: IconButton(
                              icon: seePassword1 ? iconDontSee : iconSee,
                              onPressed: () {
                                setState(() {
                                  seePassword1 = !seePassword1;
                                });
                              },
                            ),
                          ),
                          onChanged: (String value) async {
                            setState(() {
                              _password = value;
                            });
                            await Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                //Wait for 1 second
                                if (value.length < 8) {
                                  /// Shows error message if password contains less then 8 characters
                                  setState(() {
                                    errorMessage1 = true;
                                  });
                                } else {
                                  setState(() {
                                    errorMessage1 = false;
                                  });
                                }
                                _checkForRegistrationButton();
                              },
                            );
                          },
                        ),
                      ),
                      Visibility(
                        /// The error message shows, if errorMessage1 is true
                        visible: errorMessage1,
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          child: SelectableText(
                            "minCharacters".tr().toString(),
                            style:
                                TextStyle(color: Colors.red[700], fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: TextField(
                          cursorColor: Colors.grey,
                          obscureText: !seePassword2,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "repeatPassword".tr().toString(),
                            suffixIcon: IconButton(
                              icon: seePassword2 ? iconDontSee : iconSee,
                              onPressed: () {
                                setState(() {
                                  seePassword2 = !seePassword2;
                                });
                              },
                            ),
                          ),
                          onChanged: (String value) async {
                            setState(() {
                              _secPassword = value;
                            });
                            await Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                if (value != _password) {
                                  /// Show error message, if the first password input is not equal to the second input
                                  setState(() {
                                    errorMessage2 = true;
                                    passwordMessage = false;
                                  });
                                } else {
                                  setState(() {
                                    errorMessage2 = false;
                                    passwordMessage = true;
                                  });
                                }
                                _checkForRegistrationButton();
                              },
                            );
                          },
                        ),
                      ),

                      Visibility(
                        /// The error message shows, if errorMessage2 is true
                        visible: errorMessage2,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: SelectableText(
                            "pswNotMatch".tr().toString(),
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: usernameMessage,
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: SelectableText(
                            "userNameTaken".tr().toString(),
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: networkMessage,
                        child: Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: SelectableText(
                            "networkError".tr().toString(),
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
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
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),

                      /// This container contains the logic to register the new user
                      /// also with the http logic
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      Size(140.0, 50.0)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(10))),

                              /// Button is enabled if regisButton is true
                              onPressed: regisButton
                                  ? () async => {
                                        if (_admin == true)
                                          {_roleID.add(0)}
                                        else if (_admin == false &&
                                            _user == true)
                                          {_roleID.add(1)},
                                        response = await http
                                            .post(url + signupExtension,
                                                headers: {
                                                  "Content-Type":
                                                      "application/json",
                                                  "Authorization":
                                                      "Bearer $jwtToken"
                                                },
                                                body: json.encode({
                                                  "password": _password,
                                                  "roles_ids": _roleID,
                                                  "username": _username
                                                }))
                                            .timeout(const Duration(seconds: 3),
                                                onTimeout: () {
                                          return _catchTimeout();
                                        }),
                                        _username = "",
                                        _password = "",
                                        _secPassword = "",
                                        passwordMessage = false,
                                        checkResponse(),
                                        print(response.statusCode),
                                      }
                                  : null,
                              child: Text(
                                "signup".tr().toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// If the Server takes to long to answer error messages are displayed
  dynamic _catchTimeout() {
    setState(() {
      usernameMessage = false;
      passwordMessage = false;
      networkMessage = true;
    });
    return null;
  }

  /// Function checks all conditions for activating the registration button
  void _checkForRegistrationButton() {
    if (_username.length > 0 &&
        errorMessage1 == false &&
        errorMessage2 == false &&
        _password.length > 7 &&
        _secPassword.length > 1) {
      setState(() {
        regisButton = true;
      });
    } else {
      setState(() {
        regisButton = false;
      });
    }
  }

  /// Function evaluates the http response and displays the relevant messages
  void checkResponse() {
    try {
      setState(() {
        if (response.statusCode == 200) {
          usernameMessage = false;
          passwordMessage = false;
          networkMessage = false;

          /// Confirmation dialog
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              title: SelectableText("confirmation".tr().toString()),
              contentPadding: EdgeInsets.all(20.0),
              children: [
                Container(
                  height: 100,
                  width: 300,
                  alignment: Alignment.center,
                  child: SelectableText(
                    "registrationSuccess".tr().toString(),
                  ),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      _forwarding();
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(color: buttonColor),
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (response.statusCode == 500) {
          usernameMessage = true;
          passwordMessage = false;
          networkMessage = false;
        }
      });
    } on NoSuchMethodError {}
  }

  /// Is called after creating the user
  void _forwarding() {
    Navigator.pushReplacementNamed(context, "/userManagement");
  }
}
