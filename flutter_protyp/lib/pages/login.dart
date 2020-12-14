import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/registration.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:universal_io/io.dart' as osDetect;
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';

/// returns login site of application
/// Can be coloured with loginColor1 and loginColor2 in constant.dart
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "";
  String password = "";
  String jwttoken = "";
  bool errorMessage = false;

  String url = 'http://172.28.176.1:8000/users/login';
  var response;

  void onlineOs() {
    String android = "android";
    String ios = "ios";
    if (osDetect.Platform.operatingSystem == android ||
        osDetect.Platform.operatingSystem == ios) {
      mobileDevice = true;
    } else {
      mobileDevice = false;
    }
  }

  @override
  void initState() {
    onlineOs();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  loginColor1,
                  loginColor2,
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 120,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Container(
                      width: 320,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "OpenSans",
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Email",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 60,
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: !mobileDevice,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "OpenSans",
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.only(top: 14),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    hintText: 'emailAddress'.tr().toString(),
                                  ),
                                  onChanged: (value) => username = value,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'password'.tr().toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 60,
                                child: TextField(
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "OpenSans",
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.only(top: 14),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    hintText: 'password'.tr().toString(),
                                  ),
                                  onChanged: (value) => password = value,
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: errorMessage,
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              child: Text(
                                "Die Login-Daten sind falsch!",
                                style: TextStyle(
                                    color: Colors.red[700], fontSize: 20),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: () =>
                                  {print("Forgot Password Button Pressed")},
                              padding: EdgeInsets.only(right: 0),
                              child: Text(
                                'forgotPassword'.tr().toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            width: double.infinity,
                            child: RaisedButton(
                              elevation: 5,
                              onPressed: () async => {
                                {print(username)},
                                {print(password)},
                                Navigator.pushReplacementNamed(
                                    context, "/deviceOverview"),

                                response = await http.post(url,
                                    headers: {
                                      "Content-Type": "application/json"
                                    },
                                    body: json.encode({
                                      'password': password,
                                      'username': username
                                    })),
                                //print(response.body),
                                print(response.statusCode),
                                //print(json.decode(response.body.toString()))


                              //          for (var value in response.values) print(value)
//
                                //          if (response.statusCode == 200) {
                                //            print(reponse.body);
                                //        } else {
                                //      print('A network error occurred');
                                //      }
                              },
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Colors.white,
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: loginColor2,
                                  letterSpacing: 1.5,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "OpenSans",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
