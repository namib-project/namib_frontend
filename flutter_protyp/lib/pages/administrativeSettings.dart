import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';
import 'package:flutter/rendering.dart';

// This page is for administrative settings of the application

class AdministrativeSettings extends StatefulWidget {
  @override
  _AdministrativeSettingsState createState() => _AdministrativeSettingsState();
}

class _AdministrativeSettingsState extends State<AdministrativeSettings> {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
          child: Container(
        height: double.infinity,
        //Context will appear smaller on mobile devices
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
                      Linkable(
                          textAlign: TextAlign.center,
                          textColor: darkMode ? Colors.white : Colors.black,
                          style: TextStyle(fontSize: 20,),
                          text:
                              "letsEncryptUsageText".tr().toString()),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(250.0, 50.0))),
                          onPressed: () {},
                          child: Text(
                            "acceptEncryptTerms".tr().toString(),
                            style: TextStyle(fontSize: 18),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(),
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
                      ElevatedButton(
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(150.0, 50.0))),
                          onPressed: () {},
                          child: Text("disableSignup".tr().toString(),
                              style: TextStyle(fontSize: 18))),
                      //TODO Text variable an Wert von http Request anpassen
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
                      ElevatedButton(
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(150.0, 50.0))),
                          onPressed: () {},
                          child: Text("allowDataCollection".tr().toString(), style: TextStyle(fontSize: 18),))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
