import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:universal_io/io.dart' as osDetect;
import 'package:flutter_protyp/widgets/constant.dart';

import 'package:easy_localization/easy_localization.dart';

/// returns login site of application
/// Can be coloured with loginColor1 and loginColor2 in constant.dart
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

String inputEmail = "";
String inputPassword = "";
String jwttoken = "";


class _LoginState extends State<Login> {
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
              width: 400,
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 120,
                ),
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
                            onChanged: (value) => inputEmail = value,
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
                            onChanged: (value) => inputPassword = value,
                          ),
                        ),
                      ],
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
                        onPressed: () => {
                          {onlineOs()},
                          {print(inputEmail)},
                          {print(inputPassword)},
                          Navigator.pushReplacementNamed(
                              context, "/deviceOverview")
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
            ),
          ),
        ],
      ),
    );
  }
}
