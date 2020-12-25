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
                              labelText: "Passwort wiederholen",
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
                    SizedBox(
                      height: 60,
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.pushReplacementNamed(context, "/loginTest")
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
                            "Registrieren",
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
