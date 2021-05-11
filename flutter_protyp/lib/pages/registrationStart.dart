import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// This class is for creating users on the login page

class RegistrationStart extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

/// Class for user registration, will only be used at the first usage
class _RegistrationState extends State<RegistrationStart> {
  bool seePassword1 = false;
  bool seePassword2 = false;
  Icon iconSee = Icon(
    FontAwesomeIcons.eyeSlash,
    size: 17,
  );
  Icon iconDontSee = Icon(
    FontAwesomeIcons.eye,
    size: 17,
  );

  /// Variables for user inputs
  String _password = "";
  String _username = "";
  String _secPassword = "";

  /// Variables for visibility of error messages
  bool errorMessage1 = false;
  bool errorMessage2 = false;
  bool regisButton = false;
  bool usernameMessage = false;
  bool networkMessage = false;

  /// Test for http client
  String signupExtension = "users/signup";

  /// Stores the response from the controller
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
          child: SingleChildScrollView(
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 480 +
                      (errorMessage1 ? 50.0 : 0.0) +
                      (errorMessage2 ? 50.0 : 0.0) +
                      (usernameMessage ? 50.0 : 0.0) +
                      (networkMessage ? 120.0 : 0.0),
                  width: 325,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
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
                          Container(
                            alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [loginColor1, loginColor2],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                alignment: Alignment.center,
                                child: ButtonTheme(
                                  minWidth: 10,
                                  height: 50,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                    ),
                                    onPressed: () => {
                                      Navigator.pushReplacementNamed(
                                          context, "/login")
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Center(
                                        child: Icon(
                                          FontAwesomeIcons.arrowLeft,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
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
                        "enterDataPls".tr().toString(),
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
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              labelText: "username".tr().toString(),
                              suffixIcon: Icon(
                                FontAwesomeIcons.user,
                                size: 17,
                              ),
                            ),
                            onChanged: (String value) async {
                              setState(() {
                                _username = value;
                              });
                              _checkForRegistrationButton();
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
                            cursorColor: Colors.grey,
                            obscureText: !seePassword1,
                            decoration: InputDecoration(
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
                              await Future.delayed(const Duration(seconds: 1),
                                  () {
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
                                if (_secPassword != _password &&
                                    _secPassword.length > 7) {
                                  /// Show error message, if the first password input is not equal to the second input
                                  setState(() {
                                    errorMessage2 = true;
                                  });
                                } else {
                                  setState(() {
                                    errorMessage2 = false;
                                  });
                                }
                                _checkForRegistrationButton();
                              });
                            },
                          ),
                        ),
                      ),

                      ///Visibility errorMessage
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Visibility(
                          /// The error message shows, if errorMessage1 is true
                          visible: errorMessage1,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            child: SelectableText(
                              "minCharacters".tr().toString(),
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 20,
                              ),
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
                            cursorColor: Colors.grey,
                            obscureText: !seePassword2,
                            decoration: InputDecoration(
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
                                  //Wait for 1 second
                                  if (value != _password) {
                                    /// Show error message, if the first password input is not equal to the second input
                                    setState(() {
                                      errorMessage2 = true;
                                    });
                                  } else {
                                    setState(() {
                                      errorMessage2 = false;
                                    });
                                  }
                                  _checkForRegistrationButton();
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Visibility(
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
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Visibility(
                          visible: networkMessage,
                          child: Container(
                            height: 120,
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
                      ),
                      SizedBox(
                        height: 60,
                      ),

                      /// This container contains the logic to register the new user
                      /// also with the http logic
                      Container(
                        alignment: Alignment.center,
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: regisButton
                                ? [loginColor1, loginColor2]
                                : [Colors.grey[400], Colors.grey[700]],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Container(
                            alignment: Alignment.center,
                            child: TextButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      Size(300.0, 100.0)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0x00000000)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  )),
                              onPressed: regisButton
                                  ? () async => {
                                        response = await http
                                            .post(url + signupExtension,
                                                headers: {
                                                  "Content-Type":
                                                      "application/json"
                                                },
                                                body: json.encode({
                                                  "password": _password,
                                                  "username": _username
                                                }))
                                            .timeout(const Duration(seconds: 3),
                                                onTimeout: () {
                                          return _catchTimeout();
                                        }),
                                        _username = "",
                                        _password = "",
                                        _secPassword = "",
                                        _checkResponse(),
                                      }
                                  : null,
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
  void _checkResponse() {
    try {
      setState(() {
        if (response.statusCode == 200) {
          usernameMessage = false;
          networkMessage = false;

          /// Confirmation dialog
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              title: SelectableText("confirmation".tr().toString()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  18.0,
                ),
              ),
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
                      _forward();
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        color: buttonColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (response.statusCode == 500) {
          usernameMessage = true;
          networkMessage = false;
        } else if (response.statusCode == 400) {
          _forbiddenDialog(context);
        }
      });
    } on NoSuchMethodError {}
  }

  /// shows if registration over this site is forbidden by admin
  _forbiddenDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                  contentPadding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  content: Container(
                    width: 300,
                    height: 150,
                    child: Column(
                      children: <Widget>[
                        SelectableText(
                          'signUpForbidden'.tr().toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
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
          },
        );
      },
    );
  }

  /// Is called after creating the user
  /// redirects to login
  void _forward() {
    Navigator.pushReplacementNamed(context, "/login");
  }
}
