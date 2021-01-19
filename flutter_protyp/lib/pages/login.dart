import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/handlers/ThemeHandler.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:universal_io/io.dart' as osDetect;
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:flutter_protyp/widgets/appbar.dart' as AppBar;

/// returns login site of application
/// Can be coloured with loginColor1 and loginColor2 in constant.dart
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "";
  String password = "";
  bool errorMessage400 = false;
  bool errorMessage401 = false;
  bool error = false;

  var brightness;
  List<Locale> systemLocale = WidgetsBinding.instance.window.locales;

  String url = 'http://172.26.224.1:8000/users/login';
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

  ThemeChangeHandler themeChangeHandler = new ThemeChangeHandler();

  void setLanguage() {
    Locale language;
    setState(() {
      language = systemLocale.first;
    });

    if (language.toString() == "de_DE") {
      setState(() {
        themeChangeHandler.setLanguage(0, context);
      });
    } else {
      setState(() {
        themeChangeHandler.setLanguage(1, context);
      });
    }
  }

  void setTheme() {
    if (brightness.toString() != "Brightness.light") {
      setState(() {
        themeChangeHandler.changeDarkMode(context);
      });
    }
  }

  @override
  void initState() {
    onlineOs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setLanguage();
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
                          SelectableText(
                            "LOGIN",
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
                              SelectableText(
                                'username'.tr().toString(),
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
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    hintText: 'username'.tr().toString(),
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
                              SelectableText(
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
                            visible: errorMessage400,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              child: Text(
                                'error400'.tr().toString(),
                                style: TextStyle(
                                    color: Colors.red[700], fontSize: 20),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: error,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              child: Text(
                                'error'.tr().toString(),
                                style: TextStyle(
                                    color: Colors.red[700], fontSize: 20),
                              ),
                            ),
                          ),
                          //  Visibility(
                          //    visible: errorMessege401,
                          //    child: Container(
                          //      alignment: Alignment.center,
                          //      height: 50,
                          //      child: Text(
                          //        "Eines der beiden Felder ist leer!",
                          //        style: TextStyle(
                          //            color: Colors.red[700], fontSize: 20),
                          //      ),
                          //    ),
                          //  ),
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
                          Container(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: () => {
                                print("Register Button pressed"),
                                Navigator.pushReplacementNamed(
                                    context, "/registration")
                              },
                              padding: EdgeInsets.only(right: 0),
                              child: Text(
                                'signup'.tr().toString(),
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
                                setSystemPreferences(),
                                setTheme(),
                                print(brightness),
                                Navigator.pushReplacementNamed(
                                    context, "/deviceOverview"),
                                {print(username)},
                                {print(password)},
                                //Sends Http Request
                                response = await http.post(url,
                                    headers: {
                                      "Content-Type": "application/json"
                                    },
                                    body: json.encode({
                                      'password': password,
                                      'username': username
                                    })),
                                print(response.body),
                                print(response.statusCode),
//
                                if (response.statusCode == 400)
                                  {
                                    setState(() {
                                      errorMessage400 = true;
                                      errorMessage401 = false;
                                    })
                                  }
                                else if (response.statusCode == 401)
                                  {
                                    setState(() {
                                      errorMessage401 = true;
                                      errorMessage400 = false;
                                    })
                                  }
                                else if (response.statusCode == 200)
                                  {
                                    password = "",
                                    username = "",
                                    Navigator.pushReplacementNamed(
                                        context, "/deviceOverview"),
                                    jwtToken = response.body,
                                    //jwtToken =
                                    //  jwtToken.substring(9, jwtToken.length),
                                    //  print(jwtToken)

                                    setState(() {
                                      errorMessage401 = false;
                                      errorMessage400 = false;
                                    })
                                  }
                                else
                                  {
                                    setState(() {
                                      errorMessage401 = false;
                                      errorMessage400 = false;
                                    })
                                  },


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

  void setSystemPreferences() {
    brightness = MediaQuery.of(context).platformBrightness.toString();
  }
}
