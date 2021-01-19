import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device.dart';
import 'package:flutter_protyp/data/mudData.dart';
import 'package:flutter_protyp/pages/deviceOverview.dart';
import 'package:flutter_protyp/pages/handlers/ThemeHandler.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:universal_io/io.dart' as osDetect;
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:flutter_protyp/widgets/appbar.dart' as AppBar;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  String username = "";
  String password = "";
  bool errorMessage400 = false;
  bool errorMessage401 = false;
  bool networkError = false;
  bool error = false;
  bool loginButton = false;

  /// Response form get devices
  var devices;

  var brightness;
  List<Locale> systemLocale = WidgetsBinding.instance.window.locales;

  String url = 'http://172.21.112.1:8000/users/login';
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
        themeChangeHandler.changeDarkMode(context);
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

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 5),
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

                      /// New hoverable Button added
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
                                  print(deviceTest()
                                      .mud_data
                                      .acllist[0]
                                      .ace[0]
                                      .matches
                                      .dnsname),
                                  print(mudTest()),
                                  //print(
                                  //    "Testi1 should return the List of MudServices:"),
                                  //print(mudServObjs),
                                  //print(
                                  //    "Testi2 should return name of first element:"),
                                  //print(mudServObjs.first.name),
                                  setSystemPreferences(),
                                  setTheme(),
                                  print(brightness),

                                  /// Just for testing: delete when ready
                                  // Navigator.pushReplacementNamed(
                                  //     context, "/deviceOverview"),

                                  {print(username)},
                                  {print(password)},

                                  //Sends Http Request
                                  response = await http
                                      .post(url,
                                          headers: {
                                            "Content-Type": "application/json"
                                          },
                                          body: json.encode({
                                            'password': password,
                                            'username': username
                                          }))
                                      .timeout(const Duration(seconds: 7),
                                          onTimeout: () {
                                    return _handleTimeOut();
                                  }),

                                  _checkResponse(response.statusCode)
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

  dynamic _handleTimeOut() {
    setState(() {
      networkError = true;
    });
    return null;
  }

  //Activates the login button if more then one character are in the username and password field
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
          password = "";
          username = "";
          _getDevices();

          //Navigator.pushReplacementNamed(context, "/deviceOverview");

          jwtToken = json.decode(response.body)['token'];
          //jwtToken = jwtToken.substring(
          //    9, jwtToken.length),
          print(jwtToken);
          errorMessage401 = false;
          errorMessage400 = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeviceOverview(
                devices: devices,
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

  Future _getDevices() async {
    String urlDevices = 'http://172.21.112.1:8000/devices/';
    var responseDevices;
    responseDevices = await http.get(urlDevices);
    List<Device> devicesList;
    String test =
        '[{"hostname": "string","id": 0,"ip_addr": "string","last_interaction": "string","mac_addr": "string","mud_data": {"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "string"},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-01-17T21:05:00.692Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"},"mud_url": "string","vendor_class": "string"}]';
    var jsonDevices = jsonDecode(test) as List;
    List<Device> devices =
        jsonDevices.map((tagJson) => Device.fromJson(tagJson)).toList();
    Device device = devices[0];
    if (responseDevices.body.toString() == "[]") {
      devices.add(device);
    } else {
      //devices = jsonDecode(responseDevices.body) as List;
      //devicesList = devices.map((tagJson) => Device.fromJson(tagJson)).toList();
    }
  }

  Device deviceTest() {
    String test =
        '[{"hostname": "string","id": 0,"ip_addr": "string","last_interaction": "string","mac_addr": "string","mud_data": {"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "string"},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-01-17T21:05:00.692Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"},"mud_url": "string","vendor_class": "string"}]';
    var jsonDevices = jsonDecode(test) as List;
    List<Device> devices =
        jsonDevices.map((tagJson) => Device.fromJson(tagJson)).toList();
    Device device = devices[0];
    return device;
  }

  String mudTest() {
    String mud =
        '{"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "string"},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-01-17T21:04:22.265Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"}';
    var jsonMud = jsonDecode(mud);
    MUDData mudData = MUDData.fromJson(jsonMud);
    return mudData.acllist[0].ace[0].matches.dnsname;
  }
}
