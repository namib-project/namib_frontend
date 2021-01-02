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

  String username = "";
  String password = "";
  bool errorMessage400 = false;
  bool errorMessage401 = false;
  bool error = false;
  bool loginButton = false;

  var brightness;
  List<Locale> systemLocale = WidgetsBinding.instance.window.locales;

  String url = 'http://192.168.0.1:8000/users/login';
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
        selectionsLanguage = [true, false];
      });
    } else {
      setState(() {
        themeChangeHandler.setLanguage(1, context);
        selectionsLanguage = [false, true];
      });
    }
  }

  void setTheme() {
    if (brightness.toString() != "Brightness.light") {
      setState(() {
        themeChangeHandler.setDarkMode(context);
      });
    }
  }

  @override
  void initState() {
    onlineOs();
    super.initState();
  }

  void setSystemPreferences() {
    brightness = MediaQuery.of(context).platformBrightness.toString();
  }

  @override
  Widget build(BuildContext context) {
    setLanguage();
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
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              labelText: 'username'.tr().toString(),
                              suffixIcon: Icon(
                                FontAwesomeIcons.user,
                                size: 17,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                username = value;
                              });
                              checkForLoginButton();
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
                            obscureText: !seePassword,
                            decoration: InputDecoration(
                              labelText: 'password'.tr().toString(),
                              suffixIcon: IconButton(
                                icon: seePassword ? iconDontSee : iconSee,
                                onPressed: () {
                                  setState(() {
                                    seePassword = !seePassword;
                                  });
                                },
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                              checkForLoginButton();
                            },
                          ),
                        ),
                      ),

                      /// Here the ErrorMessages have to be added!!!

                      Visibility(
                        visible: errorMessage400,
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: Text(
                            'error400'.tr().toString(),
                            style:
                                TextStyle(color: Colors.red[700], fontSize: 20),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: error,
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: Text(
                            'error'.tr().toString(),
                            style:
                                TextStyle(color: Colors.red[700], fontSize: 20),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 20, 5),
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            child: Text(
                              'forgotPassword'.tr().toString(),
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
                              'signup'.tr().toString(),
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async => {
                          setSystemPreferences(),
                          setTheme(),
                          print(brightness),

                          /// Just for testing: delete when ready
                          Navigator.pushReplacementNamed(
                              context, "/deviceOverview"),

                          {print(username)},
                          {print(password)},

                          //Sends Http Request
                          response = await http.post(url,
                              headers: {"Content-Type": "application/json"},
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
                              Navigator.pushReplacementNamed(
                                  context, "/deviceOverview"),
                              jwtToken = response.body,
                              jwtToken = jwtToken.substring(9, jwtToken.length),
                              print(jwtToken),
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

                          password = "",
                          username = "",
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: loginButton
                                  ? [loginColor1, loginColor2]
                                  : [Colors.grey[400], Colors.grey[700]],
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
      ),
    );
  }

  void checkForLoginButton() {
    if (username.length > 1 && password.length > 1) {
      setState(() {
        loginButton = true;
      });
    } else {
      setState(() {
        loginButton = false;
      });
    }
  }
}
