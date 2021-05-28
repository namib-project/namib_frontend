import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:http/http.dart' as http;

/// This page is for administrative settings of the application

class AdministrativeSettings extends StatefulWidget {
  @override
  _AdministrativeSettingsState createState() => _AdministrativeSettingsState();
}

class _AdministrativeSettingsState extends State<AdministrativeSettings> {
  /// Future map for holding data
  Future<Map<String, dynamic>> globaleConfigs;

  @override
  void initState() {
    super.initState();
    globaleConfigs = fetchGlobaleConfigs();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        /// FutureBuilder for building the page with future values
        child: FutureBuilder<Map<String, dynamic>>(
          future: globaleConfigs,
          builder: (context, snapshot) {
            bool collectData = false;
            if (snapshot.hasData) {
              if (snapshot.data["CollectDeviceData"] != null) {
                if ("true".compareTo(snapshot.data["CollectDeviceData"]) == 0) {
                  collectData = true;
                }
              }
              bool allowSignup = false;
              if (snapshot.data["AllowUserSignup"] != null) {
                if ("true".compareTo(snapshot.data["AllowUserSignup"]) == 0) {
                  allowSignup = true;
                }
              }
              return Container(
                height: double.infinity,

                /// Context will appear smaller on mobile devices
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 120,
                  ),
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 700,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 70,
                                alignment: Alignment.center,
                                child: SelectableText(
                                  "administrativeSettings".tr().toString(),
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              //TODO geplante Einstellung bisher noch nicht integriert
                              // Linkable(
                              //     textAlign: TextAlign.center,
                              //     textColor: darkMode
                              //         ? Colors.white
                              //         : Colors.black,
                              //     style: TextStyle(
                              //       fontSize: 20,
                              //     ),
                              //     text: "letsEncryptUsageText"
                              //         .tr()
                              //         .toString()),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // ElevatedButton(
                              //     style: ButtonStyle(
                              //         minimumSize:
                              //             MaterialStateProperty.all(
                              //                 Size(250.0, 50.0))),
                              //     onPressed: () {},
                              //     child: Text(
                              //       "acceptEncryptTerms".tr().toString(),
                              //       style: TextStyle(fontSize: 18),
                              //     )),
                              // SizedBox(
                              //   height: 15,
                              // ),
                              // Divider(),
                              SizedBox(
                                height: 10,
                              ),
                              SelectableText(
                                "signupFunction".tr().toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Transform.scale(
                                /// Transform widget for sizing of the checkboxes
                                scale: 1.5,
                                child: Checkbox(
                                  value:
                                      allowSignup != null ? allowSignup : false,
                                  fillColor:
                                      MaterialStateProperty.all(buttonColor),
                                  onChanged: (value) {
                                    updateAllowSignupValue(value);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),
                              SelectableText(
                                "collectData".tr().toString(),
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Transform.scale(
                                // Transform widget for sizing of the checkboxes
                                scale: 1.5,
                                child: Checkbox(
                                  value: collectData,
                                  fillColor:
                                      MaterialStateProperty.all(buttonColor),
                                  onChanged: (value) {
                                    updateCollectDeviceDataValue(value);
                                  },
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
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Container(
                width: 600,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SelectableText("wentWrongError".tr().toString()),
                    ElevatedButton(
                        child: Text(
                          "reload".tr().toString(),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, "/administrativeSettings");
                        })
                  ],
                ),
              );
            } else {
              return SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  /// This function fetches the data of the globale config variables CollectDeviceData and AllowUserSignup from controller
  Future<Map<String, dynamic>> fetchGlobaleConfigs() async {
    String collectDeviceExtension = "config?keys=CollectDeviceData";

    var collectResponse = await http
        .get(Uri.parse(url + collectDeviceExtension), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    });

    String allowSignupExtension = "config?keys=AllowUserSignup";
    var allowSignupResponse = await http
        .get(Uri.parse(url + allowSignupExtension), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    });
    if (collectResponse.statusCode == 200 &&
        allowSignupResponse.statusCode == 200) {
      Map<String, dynamic> data = {};
      data.addAll(jsonDecode(collectResponse.body));
      data.addAll(jsonDecode(allowSignupResponse.body));
      return data;
    }
    return null;
  }

  /// This function updates the value of AllowUserSignup at controller
  void updateAllowSignupValue(bool value) async {
    String allowSignupExtension = "config?keys=AllowUserSignup";
    Map<String, dynamic> _data = {"AllowUserSignup": value.toString()};
    await http.patch(Uri.parse(url + allowSignupExtension),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        },
        body: jsonEncode(_data));
    Navigator.pushReplacementNamed(context, "/administrativeSettings");
  }

  /// This function updates the value of CollectDeviceData at controller
  void updateCollectDeviceDataValue(bool value) async {
    String allowSignupExtension = "config?keys=CollectDeviceData";
    Map<String, dynamic> _data = {"CollectDeviceData": value.toString()};
    await http.patch(Uri.parse(url + allowSignupExtension),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        },
        body: jsonEncode(_data));
    Navigator.pushReplacementNamed(context, "/administrativeSettings");
  }
}
