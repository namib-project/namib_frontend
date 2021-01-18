import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/mudData.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:easy_localization/easy_localization.dart';
import "dart:convert";

import "package:flutter_protyp/data/device.dart";

/// just for testing can be deleted

/// idea is from this Video: https://www.youtube.com/watch?v=Fo04xk9gIFo
/// a better way may be: https://www.youtube.com/watch?v=8fFoLs9qVQA (see data Folder)
/// its basically the same but the second variant saves a lot of effort


/// I think we should also add the source of the MudProfile, to overwrite it with the new changes
class Device1 {
  String deviceName;
  String mudName;

  Device1(this.deviceName, this.mudName);

  Device1.fromJson(Map<String, dynamic> json) {
    deviceName = json["deviceName"];
    mudName = json["mudName"];
  }
}

class LanguageTest extends StatefulWidget {
  @override
  _LanguageTestState createState() => _LanguageTestState();
}

class _LanguageTestState extends State<LanguageTest> {


 @override
 Widget build(BuildContext context) {
 //  return Scaffold(
 //    appBar: MainAppbar(),
 //    drawer: MainDrawer(),
 //    body: Center(
 //      child: Padding(
 //        padding: const EdgeInsets.only(top: 50),
 //        child: Column(
 //          children: <Widget>[
 //            Text(testDevice1.deviceName),
 //            Text(testDevice1.mudName),
 //            SizedBox(
 //              height: 50,
 //            ),

 //            /// here we try to use the Device from the data folder
 //            Text(testDevice2.deviceName.toString()),
 //            Text(testDevice2.mudName.toString()),
 //          ],
 //        ),
 //      ),
 //    ),
 //  );
 }
}
