import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_protyp/widgets/constant.dart';

class OwnUser extends StatefulWidget {
  @override
  _OwnUserState createState() => _OwnUserState();
}

class _OwnUserState extends State<OwnUser> {
  String username = "";
  String url = "http://192.168.112.1:8000/users/me";

  String test = "";
  var response;
  String myJson;
  Map clearJson;
  String token;
  var parts = null;
  var payload = null;
  var normalized;
var resp;
var payloadMap;
bool messege = false;

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
                      'useroverview'.trim().toString(),
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Visibility(
                  visible: messege,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                     username.trim().toString(),
                      style: TextStyle(
                          color: Colors.red[700], fontSize: 20),
                    ),
                  ),
                ),
              Container(
                child: RaisedButton(
                  onPressed: ()  => {

                    print(jwtToken),

                  myJson = jwtToken,
                  clearJson = jsonDecode(myJson),
                  token = clearJson["token"],

                  parts = token.split('.'),
                   payload = parts[1],
                  normalized = base64Url.normalize(payload),

                  resp = utf8.decode(base64Url.decode(normalized)),
                  payloadMap = json.decode(resp),
                  print(payloadMap["id"]),
                    print(payloadMap["username"]),

                    username = payloadMap["username"],

                    messege = true

                  },
                  child: Text("Daten holen"),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
