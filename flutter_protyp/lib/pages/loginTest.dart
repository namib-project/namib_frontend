import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/handlers/ThemeHandler.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:universal_io/io.dart' as osDetect;
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:flutter_protyp/widgets/appbar.dart' as AppBar;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginTest extends StatefulWidget {
  @override
  _LoginTestState createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  bool seePassword = false;
  Icon iconSee = Icon(
    FontAwesomeIcons.eyeSlash,
    size: 17,
  );
  Icon iconDontSee = Icon(
    FontAwesomeIcons.eye,
    size: 17,
  );

  @override
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
                height: 480,
                width: 325,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Hallo",
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
                      "Bitte loggen Sie sich ein",
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
                              labelText: "Email Addresse",
                              suffixIcon: Icon(
                                FontAwesomeIcons.envelope,
                                size: 17,
                              )),
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
                              labelText: "Passwort",
                              suffixIcon: IconButton(
                                icon: seePassword ? iconDontSee : iconSee,
                                onPressed: () {
                                  setState(() {
                                    seePassword = !seePassword;
                                  });
                                },
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 20, 5),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          child: Text(
                            "Passwort vergessen",
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () => {
                            Navigator.pushReplacementNamed(
                                context, "/registrationStart")
                          },
                          child: Text(
                            "Registrieren",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.pushReplacementNamed(
                            context, "/deviceOverview")
                      },
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
                            "Login",
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
}
