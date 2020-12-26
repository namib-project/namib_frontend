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

class RegistrationStart extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

//Class for user registration, will only be used at the first usage
class _RegistrationState extends State<RegistrationStart> {
  bool seePassword = false;
  Icon iconSee = Icon(
    FontAwesomeIcons.eyeSlash,
    size: 17,
  );
  Icon iconDontSee = Icon(
    FontAwesomeIcons.eye,
    size: 17,
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
  String url = "http://172.29.144.1:8000/users/signup";
  var response;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  loginColor1,
                  loginColor2,
                ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                "NAMIB",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "OpenSans",
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 480 +
                    (errorMessage1 ? 50.0 : 0.0) +
                    (errorMessage2 ? 50.0 : 0.0) +
                    (usernameMessage ? 50.0 : 0.0) +
                    (networkMessage ? 50.0 : 0.0),
                width: 325,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () => {
                            Navigator.pushReplacementNamed(
                                context, "/loginTest")
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [loginColor1, loginColor2],
                              ),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Bitte geben Sie ihre Daten ein",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 250,
                      child: Theme(
                        data: ThemeData(
                          primaryColor: primaryColor,
                          accentColor: primaryColor,
                          hintColor: Colors.grey,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "username".tr().toString(),
                            suffixIcon: Icon(
                              FontAwesomeIcons.envelope,
                              size: 17,
                            ),
                          ),
                          onChanged: (String value) async {
                            setState(() {
                              username = value; //Username set to variable
                            });
                            checkForRegistrationButton(); //Check, if all conditions for enabling registration button are true
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: Theme(
                        data: ThemeData(
                          primaryColor: primaryColor,
                          accentColor: primaryColor,
                          hintColor: Colors.grey,
                        ),
                        child: TextField(
                          obscureText: !seePassword,
                          decoration: InputDecoration(
                            labelText: "password".tr().toString(),
                            suffixIcon: IconButton(
                              icon: seePassword ? iconDontSee : iconSee,
                              onPressed: () {
                                setState(() {
                                  seePassword = !seePassword;
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
                    ),

                    ///Visibility errorMessage
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Visibility(
                        //The error message shows, if errorMessage1 is true
                        visible: errorMessage1,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: SelectableText(
                            "minCharacters".tr().toString(),
                            style:
                                TextStyle(color: Colors.red[700], fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: Theme(
                        data: ThemeData(
                          primaryColor: primaryColor,
                          accentColor: primaryColor,
                          hintColor: Colors.grey,
                        ),
                        child: TextField(
                          obscureText: !seePassword,
                          decoration: InputDecoration(
                            labelText: "repeatPassword".tr().toString(),
                            suffixIcon: IconButton(
                              icon: seePassword ? iconDontSee : iconSee,
                              onPressed: () {
                                setState(() {
                                  seePassword = !seePassword;
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
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Visibility(
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
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Visibility(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Visibility(
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
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    InkWell(
                      onTap: regisButton
                          ? () async => {
                                response = await http
                                    .post(url,
                                        headers: {
                                          "Content-Type": "application/json"
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
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [loginColor1, loginColor2],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "signup".tr().toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
                            Navigator.pushReplacementNamed(context, "/login");
                          },
                          child: Text("Ok"),
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
