import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/themingService.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:universal_io/io.dart' as osDetect;
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

/// This class contains the hole login-functions and permission handling
class _LoginState extends State<Login> {
  /// Vars that lets the password appear in text or dots
  bool seePassword = false;
  Icon iconSee = Icon(
    FontAwesomeIcons.eyeSlash,
    size: 17,
  );
  Icon iconDontSee = Icon(
    FontAwesomeIcons.eye,
    size: 17,
  );

  /// User vars
  String _username = "";
  String _password = "";

  ///Variables for visibility of error messages
  bool errorMessage400 = false;
  bool errorMessage401 = false;
  bool networkError = false;
  bool error = false;
  bool loginButton = false;

  /// Var for saving the brightness state of the device
  String brightness;

  /// URL extensions
  String loginExtension = 'users/login';
  String tokenExtension = 'users/refresh_token';

  /// Stores the response from the controller
  var response;
  var newToken;

  /// Creates a time-area for the refresh-token-functions
  static const oneSec = const Duration(seconds: 840);

  /// This method scans the operating system and starts if its true the mobile device version
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
    super.initState();
  }

  /// This method sets the brightness for the hole app
  void setSystemPreferences() {
    brightness = MediaQuery.of(context).platformBrightness.toString();
  }

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
                  width: 325,
                  height: 480 +
                      (error ? 50.0 : 0.0) +
                      (errorMessage400 ? 50.0 : 0.0),
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
                        'hello'.tr().toString(),
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
                        'loginPls'.tr().toString(),
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
                                _username = value;
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
                                _password = value;
                              });
                              checkForLoginButton();
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: errorMessage401,
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: Text(
                            'error401'.tr().toString(),
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
                      Visibility(
                        /// The error message shows, if networkError is true
                        visible: networkError,
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          child: SelectableText(
                            "networkErrorLogin".tr().toString(),
                            style:
                                TextStyle(color: Colors.red[700], fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
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

                      /// This container contains the login-button which handles the login-functions
                      /// with the http-request
                      Container(
                        alignment: Alignment.center,
                        width: 250,
                        height: 50,
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
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            alignment: Alignment.center,
                            child: TextButton(
                              style: ButtonStyle(
                                  minimumSize:
                                      MaterialStateProperty.all(Size(300, 100)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0x00000000)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  )),
                              onPressed: loginButton
                                  ? () async => {
                                        setSystemPreferences(),

                                        //Sends Http Request
                                        response = await http
                                            .post(url + loginExtension,
                                                headers: {
                                                  "Content-Type":
                                                      "application/json",
                                                },
                                                body: json.encode({
                                                  'password': _password,
                                                  'username': _username
                                                }))
                                            .timeout(const Duration(seconds: 7),
                                                onTimeout: () {
                                          return _handleTimeOut();
                                        }),
                                        _checkResponse(response.statusCode),
                                      }
                                  : null,
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

  /// Displays message if the http response takes too long
  dynamic _handleTimeOut() {
    setState(() {
      networkError = true;
    });
    return null;
  }

  /// Activates the login button if more then one characters are in the username and password field
  void checkForLoginButton() {
    if (_username.length > 1 && _password.length > 7) {
      setState(() {
        loginButton = true;
      });
    } else {
      setState(() {
        loginButton = false;
      });
    }
  }

  /// Evaluates the http response code and displays the messages
  void _checkResponse(int statusCode) {
    try {
      setState(() {
        if (statusCode == 400) {
          errorMessage400 = true;
          errorMessage401 = false;
        } else if (statusCode == 401) {
          errorMessage401 = true;
          errorMessage400 = false;
        } else if (statusCode == 200) {
          new Timer.periodic(oneSec, (Timer t) => _refreshToken());
          _password = "";
          _username = "";
          jwtToken = json.decode(response.body)['token'];
          decodeToken();
          testPermissions();
          errorMessage401 = false;
          errorMessage400 = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ThemingService(
                brightness: brightness,
              ),
            ),
          );
        } else {
          errorMessage401 = false;
          errorMessage400 = false;
        }
      });
    } on NoSuchMethodError {}
  }

  /// Function to get the permission from the JWT-Token
  void decodeToken() {
    String _token;
    _token = jwtToken;
    var parts = _token.split('.');
    var payload = parts[1];
    var normalized = base64Url.normalize(payload);
    var resp = utf8.decode(base64Url.decode(normalized));
    permissions = jsonDecode(resp)["permissions"];
    userID = jsonDecode(resp)["sub"];
  }

  /// Function for set the access permission for the application
  Future testPermissions() async {
    Function eq = const ListEquality().equals;
    List<dynamic> user = ["**/list", "**/read"];
    List<dynamic> admin = ["**"];
    if (eq(admin, permissions)) {
      adminAccess = true;
      userAccess = false;
      roleID = 0;
    } else if (eq(user, permissions)) {
      userAccess = true;
      adminAccess = false;
      roleID = 1;
    }
  }

  ///This function refreshes the JWT token for authorization
  Future _refreshToken() async {
    var test = await http.get(url + tokenExtension, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    });
    newToken = json.decode(test.body)['token'];
    jwtToken = newToken;
  }
}
