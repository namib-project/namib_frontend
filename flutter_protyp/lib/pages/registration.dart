import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/widgets/appbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

//Class for user registration, will only be used at the first usage
class _RegistrationState extends State<Registration> {
  ///Variables for user inputs
  String password = "";
  String username = "";
  String secPassword = "";

  ///Variables for visibility of error messages
  bool errorMessage1 = false;
  bool errorMessage2 = false;
  bool passwordMessage = false;
  bool regisButton = false;
  bool retryMessage = false;

  ///Test for http client
  String url = "http://172.28.176.1:8000/users/signup";
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 70,
                      alignment: Alignment.center,
                      child: Text(
                        "Registrieren",
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
                      child: TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Benutzername"),
                        onChanged: (String value) async {
                          setState(() {
                            username = value; //Username set to variable
                          });
                          checkForRegistrationButton(); //Check, if all conditions for enabling registration button are true
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
                            labelText: "Passwort"),
                        onChanged: (String value) async {
                          setState(() {
                            password = value; //Password set to variable
                          });
                          await Future.delayed(const Duration(seconds: 1), () {
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
                        child: Text(
                          "Das Passwort muss mindestens 8 Zeichen haben",
                          style:
                              TextStyle(color: Colors.red[700], fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      alignment: Alignment.center,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Passwort wiederholen"),
                        onChanged: (String value) async {
                          setState(() {
                            secPassword = value;
                          });
                          await Future.delayed(const Duration(seconds: 1), () {
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
                          child: Text(
                            "Die eingegebenen Passwörter stimmen nicht überein",
                            style:
                                TextStyle(color: Colors.red[700], fontSize: 20),
                          )),
                    ),
                    Visibility(
                      //The error message shows, if passwordMessage is true
                      visible: passwordMessage,
                      child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: Text(
                            "Das Passwort ist lang genug und stimmt überein",
                            style: TextStyle(
                                color: Colors.green[700], fontSize: 20),
                          )),
                    ),
                    Visibility(
                      visible: retryMessage,
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          "Da hat etwas nicht geklappt probier es erneut",
                          style:
                              TextStyle(color: Colors.red[700], fontSize: 20),
                        ),
                      ),
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
                                      response = await http.post(url,
                                          headers: {
                                            "Content-Type": "application/json"
                                          },
                                          body: json.encode({
                                            "password": password,
                                            "username": username
                                          })),
                                      print(response.statusCode),
                                      retryMessage = false,
                                      if (response.statusCode != "200")
                                        {
                                          passwordMessage = false,
                                        }
                                      else
                                        {
                                          passwordMessage = false,
                                        }
                                    }
                                : null,
                            child: Text(
                              "Registrieren",
                              style: TextStyle(fontSize: 20),
                            ),
                            padding: EdgeInsets.all(15),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
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
}
