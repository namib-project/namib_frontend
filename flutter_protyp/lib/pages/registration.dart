import 'dart:io';
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

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

//Class for user registration, will only be used at the first usage
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
  String password = "";
  String username = "";
  String secPassword = "";

  ///Variables for visibility of error messages
  bool errorMessage1 = false;
  bool errorMessage2 = false;
  bool passwordMessage = false;
  bool regisButton = false;
  bool usernameMessage = false;
  bool networkMessage = false;

  ///Test for http client
  String url = "http://172.19.0.1:8000/users/signup";
  var response;

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
          child: Container(
        height: double.infinity,
        //Context will appear smaller on mobile devices
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 120,
          ),
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
                          "signup".tr().toString(),
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
                              labelText: "username".tr().toString()),
                          onChanged: (String value) async {
                            setState(() {
                              username = value; //Username set to variable
                            });
                            checkForRegistrationButton(); //Check, if all conditions for enabling registration button are true
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
                              password = value; //Password set to variable
                            });
                            await Future.delayed(const Duration(seconds: 1),
                                () {
                              //Wait for 1 second
                              if (value.length < 8) {
                                //Shows error message if password contains less then 8 characters
                                setState(() {
                                  errorMessage1 = true;
                                });
                              } else {
                                setState(() {
                                  errorMessage1 = false;
                                });
                              }
                              checkForRegistrationButton(); //Check, if all conditions for enabling registration button are true
                            });
                          },
                        ),
                      ),
                      Visibility(
                        //The error message shows, if errorMessage1 is true
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
                              secPassword = value;
                            });
                            await Future.delayed(const Duration(seconds: 1),
                                () {
                              //Wait for 1 second
                              if (value != password) {
                                //Show error message, if the first password input is not equal to the second input
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
                              checkForRegistrationButton(); //Check, if all conditions for enabling registration button are true
                            });
                          },
                        ),
                      ),
                      Visibility(
                        //The error message shows, if errorMessage2 is true
                        visible: errorMessage2,
                        child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: SelectableText(
                              "pswNotMatch".tr().toString(),
                              style: TextStyle(
                                  color: Colors.red[700], fontSize: 20),
                            )),
                      ),
                      Visibility(
                        visible: usernameMessage,
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: SelectableText(
                            "userNameTaken".tr().toString(),
                            style:
                                TextStyle(color: Colors.red[700], fontSize: 20),
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
                            style:
                                TextStyle(color: Colors.red[700], fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            RaisedButton(
                              //Button is enabled if regisButton is true
                              onPressed: regisButton
                                  ? () async => {
                                        response = await http
                                            .post(url,
                                                headers: {
                                                  "Content-Type":
                                                      "application/json"
                                                },
                                                body: json.encode({
                                                  "password": password,
                                                  "username": username
                                                }))
                                            .timeout(const Duration(seconds: 3),
                                                onTimeout: () {
                                          return catchTimeout();
                                        }),
                                        username = "",
                                        password = "",
                                        secPassword = "",
                                        passwordMessage = false,
                                        checkResponse(),
                                      }
                                  : null,
                              child: Text(
                                "signup".tr().toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              padding: EdgeInsets.all(15),
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
      )),
    );
  }

  dynamic catchTimeout() {
    setState(() {
      usernameMessage = false;
      passwordMessage = false;
      networkMessage = true;
    });
    return null;
  }

  //Function checks all conditions for activating the registration button
  void checkForRegistrationButton() {
    if (username.length > 1 &&
        errorMessage1 == false &&
        errorMessage2 == false &&
        password.length > 7 &&
        secPassword.length > 1) {
      setState(() {
        regisButton = true;
      });
    } else {
      setState(() {
        regisButton = false;
      });
    }
  }

  void checkResponse() {
    try {
      setState(() {
        if (response.statusCode == 200) {
          usernameMessage = false;
          passwordMessage = false;
          networkMessage = false;

          showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                    title: SelectableText("confirmation".tr().toString()),
                    contentPadding: EdgeInsets.all(20.0),
                    children: [
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: SelectableText(
                            "registrationSuccess".tr().toString()),
                      ),
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(color: buttonColor),
                          ),
                        ),
                      )
                    ],
                  ));
        } else if (response.statusCode == 500) {
          usernameMessage = true;
          passwordMessage = false;
          networkMessage = false;
        }
      });
    } on NoSuchMethodError {}
  }
}
