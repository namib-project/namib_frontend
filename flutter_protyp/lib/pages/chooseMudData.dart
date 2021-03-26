import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device_mud/mudData.dart';
import 'package:flutter_protyp/data/device_mud/mudGuess.dart';
import 'package:flutter_protyp/pages/chooseMudDataTable.dart';
import 'package:flutter_protyp/pages/roomTable.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_protyp/data/room.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';

import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseMudData extends StatefulWidget {
  ChooseMudData({
    Key key,
    @required this.device,
  }) : super(key: key);

  final Device device;

  _ChooseMudDataState createState() => _ChooseMudDataState();
}

class _ChooseMudDataState extends State<ChooseMudData> {
  Future<List<MudGuess>> mudGuessList;

  @override
  void initState() {
    super.initState();
    mudGuessList = getMudGuessList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText("Details"),
        actions: <Widget>[
          Padding(
            padding: mobileDevice
                ? EdgeInsets.fromLTRB(12, 5, 12, 12)
                : EdgeInsets.fromLTRB(0, 5, 12, 12),
            child: SettingsPopup(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // This future builder element put in the different devices after these will be loaded
            // The future builder element a delayed sending of context
            FutureBuilder<List<MudGuess>>(
              future: mudGuessList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: ChooseMudDataTable(
                    mudGuessList: snapshot.data,
                    device: widget.device,
                  ));
                } else if (snapshot.hasError) {
                  // If the process failed this message returns
                  print(snapshot.error);
                  return Container(
                    width: 600,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SelectableText("wentWrongError".tr().toString()),
                          RaisedButton(
                              child: Text("reload".tr().toString()),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, "/chooseRoom");
                              })
                        ]),
                  );
                }
                // By default, show a loading spinner.
                else {
                  return SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

///TODO: make this future wich gets all the rooms from the devicesList
Future<List<MudGuess>> getMudGuessList() async {
  // String devicesExtension = 'devices';
  // response = await http.get(url + devicesExtension, headers: {
  //   "Content-Type": "application/json",
  //   "Authorization": "Bearer $jwtToken"
  // }).timeout(const Duration(seconds: 5), onTimeout: () {
  //   return _handleTimeOut();
  // });

  String test =
      '[{"manufacturer_name": "ManName1","model_name": "ModelName1","mud_url": "url1"}, {"manufacturer_name": "ManName2","model_name": "ModelName2","mud_url": "url2"}, {"manufacturer_name": "ManName3","model_name": "ModelName3","mud_url": "url3"}]';
  //print("Response code: " + response.statusCode.toString());
  //print(response.body);

  //if (response.statusCode == 200) {

  var jsonMudGuess = jsonDecode(test) as List;
  List<MudGuess> mudGuessListTest =
      jsonMudGuess.map((tagJson) => MudGuess.fromJson(tagJson)).toList();

  return mudGuessListTest;

  //} else {
  //throw Exception("Failed to get Data");
  //}
  //TODO bei release auf http request umstellen
}
