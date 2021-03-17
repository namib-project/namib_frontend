import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/data/device_mud/mudData.dart';
import 'package:flutter_protyp/pages/handlers/ThemeHandler.dart';
import 'package:flutter_protyp/pages/themingService.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:universal_io/io.dart' as osDetect;
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:collection/collection.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

/// This is a test to get a List of Services from All Services which are known as json
/// Should be Deleted when ready
String allMudServicesStr =
    '{ "count": 3, "next": null, "previous": null, "results": [{ "name": "Foo Service","product": null,"method": null},{"name": "DNS Service","product": null,"method": null},{"name": "NTP Service","product": null,"method": null}]}';
var resultObjjs = jsonDecode(allMudServicesStr)['results'] as List;
List<MUDData> mudServObjs =
    resultObjjs.map((tagJson) => MUDData.fromJson(tagJson)).toList();

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

  String loginExtension = 'users/login';

  /// Stores the response from the controller
  var response;

  // This method scans the operating system and starts if its true the mobile device version
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

  // This method sets the brightness for the hole app
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
                      Visibility(
                        //The error message shows, if networkError is true
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

                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(0, 0, 20, 5),
                      //   child: Container(
                      //     alignment: Alignment.centerRight,
                      //     child: FlatButton(
                      //       child: Text(
                      //         'forgotPassword'.tr().toString(),
                      //         style: TextStyle(
                      //           color: primaryColor,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 15,
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

                      /// New hoverable Button added
                      // This container contains the login-button which handles the login-functions
                      // also with the http-request
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
                            child: ButtonTheme(
                              minWidth: 300,
                              height: 100,
                              child: FlatButton(
                                color: Color(0x00000000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                onPressed: () async => {
                                  setSystemPreferences(),
                                  print(brightness),

                                  /// just for testing
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ThemingService(
                                        brightness: brightness,
                                      ),
                                    ),
                                  ),

                                  {print(_username)},
                                  {print(_password)},

                                  //Sends Http Request
                                  response = await http
                                      .post(url + loginExtension,
                                          headers: {
                                            "Content-Type": "application/json",
                                            // 'Charset': 'utf-8'
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
                                  decodeToken(),

                                  /// TODO: permissions have to be set
                                  //testPermissions(),
                                },
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

  // Displays message if the http response takes to long
  dynamic _handleTimeOut() {
    setState(() {
      networkError = true;
    });
    return null;
  }

  //Activates the login button if more then one character are in the username and password field
  void checkForLoginButton() {
    if (_username.length > 1 && _password.length > 1) {
      setState(() {
        loginButton = true;
      });
    } else {
      setState(() {
        loginButton = false;
      });
    }
  }

  //Evaluates the http response an displays the relevant messages
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
          _password = "";
          _username = "";
          //_getDevices();
          jwtToken = json.decode(response.body)['token'];
          //jwtToken = jwtToken.substring(
          //    9, jwtToken.length),
          //TODO request für Benutzerrollen
          print(jwtToken); //TODO richtige List übergeben
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

  // Function getting the list of devices in network from controller
  Future _getDevices() async {
    String urlDevices = 'http://172.31.160.1:8000/devices/';
    var responseDevices;
    responseDevices = await http.get(urlDevices);
    var jsonDevices = jsonDecode(responseDevices) as List;
    List<Device> devicesTest =
        jsonDevices.map((tagJson) => Device.fromJson(tagJson)).toList();
    return devicesTest;
  }

  //For tests
  List<Device> deviceTest() {
    String test =
        '[{"hostname": "string","id": 0,"ip_addr": "string","last_interaction": "string","mac_addr": "string","mud_data": {"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "ntp.org"},"name": "string"},{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "weather.com"},"name": "string"},{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice", "dnsname": "xyz.media"},"name": "string"},{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "storage.de"},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-01-23T10:35:17.609Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"},"mud_url": "string","vendor_class": "string"}, {"hostname": "string","id": 0,"ip_addr": "string","last_interaction": "string","mac_addr": "string","mud_data": {"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "string"},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-01-17T21:05:00.692Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"},"mud_url": "string","vendor_class": "string"}]';
    var jsonDevices = jsonDecode(test) as List;
    List<Device> devices =
        jsonDevices.map((tagJson) => Device.fromJson(tagJson)).toList();
    return devices;
  }

  //for tests
  String mudTest() {
    String mud =
        '{"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "string"},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-01-17T21:04:22.265Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"}';
    var jsonMud = jsonDecode(mud);
    MUDData mudData = MUDData.fromJson(jsonMud);
    return mudData.acllist[0].ace[0].matches.dnsname;
  }

  // Funtion to get the permission from the JWT-Token
  void decodeToken() {
//    String myJson;
    //  Map clearJson;
    String _token;
    //var payloadMap;

    _token = jwtToken;
    //clearJson = jsonDecode(myJson);
    //token = clearJson["token"];
    var parts = _token.split('.');
    var payload = parts[1];
    var normalized = base64Url.normalize(payload);
    var resp = utf8.decode(base64Url.decode(normalized));
    //payloadMap = resp;

    permissions = jsonDecode(resp)["permissions"];
    print(permissions);

    print(resp);
  }

  // Function for set the access permission for the application
  Future testPermissions() async {
    Function eq = const ListEquality().equals;

    List<dynamic> user = ["asdf"];
    List<dynamic> admin = [];

    if (eq(admin, permissions) == true) {
      print("babo");
      adminAccess = true;
    } else if (eq(user, permissions) == true) {
      print("lappen");
      userAccess = true;
      adminAccess = false;
    }
    return adminAccess;
  }
}
