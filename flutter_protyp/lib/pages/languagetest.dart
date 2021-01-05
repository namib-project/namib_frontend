import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:easy_localization/easy_localization.dart';
import "dart:convert";

/// just for testing can be deleted

/// idea is from this Video: https://www.youtube.com/watch?v=Fo04xk9gIFo
/// a better way may be: https://www.youtube.com/watch?v=8fFoLs9qVQA

String testJson = '{"name": "Gerätename1", "mudName": "Mudname1"}';

/// I think we should also add the source of the MudProfile, to overwrite it with the new changes
class Device {
  String deviceName;
  String mudName;

  Device(this.deviceName, this.mudName);

  Device.fromJson(Map<String, dynamic> json) {
    deviceName = json["name"];
    mudName = json["mudName"];
  }
}

class LanguageTest extends StatefulWidget {
  @override
  _LanguageTestState createState() => _LanguageTestState();
}

class _LanguageTestState extends State<LanguageTest> {
  Device testDevice = Device.fromJson(json.decode(testJson));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Text(testDevice.deviceName),
              Text(testDevice.mudName)
            ],
          ),
        ),
      ),
    );
  }
}
