import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_protyp/widgets/constant.dart';

class OwnUser extends StatefulWidget {
  @override
  _OwnUserState createState() => _OwnUserState();
}

class _OwnUserState extends State<OwnUser> {
  String username = "";
  String url = "http://172.28.176.1:8000/users/me";

  String test = "";
  var response;

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: SelectableText(
                    "Übersicht",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    height: 70,
                    child: SelectableText(
                      "Benutzername: $username $test",
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              Container(
                child: RaisedButton(
                  onPressed: () async => {
                    response = await http.get(url, headers: {"Content-Type": "application/json"}),
                    test = response.body,
                    print(response.statusCode),
                  },
                  child: Text("Daten holen"),
                ),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
