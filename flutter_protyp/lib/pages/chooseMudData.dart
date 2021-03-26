import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device_mud/mudData.dart';
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
  Future<List<MUDData>> mudDataList;

  @override
  void initState() {
    super.initState();
    mudDataList = getMudDataList();
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
            FutureBuilder<List<MUDData>>(
              future: mudDataList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: ChooseMudDataTable(
                    mudDataList: snapshot.data,
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
Future<List<MUDData>> getMudDataList() async {
  // String devicesExtension = 'devices';
  // response = await http.get(url + devicesExtension, headers: {
  //   "Content-Type": "application/json",
  //   "Authorization": "Bearer $jwtToken"
  // }).timeout(const Duration(seconds: 5), onTimeout: () {
  //   return _handleTimeOut();
  // });

  String test =
      '[{"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-23T18:49:40.185Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "cMudName897","url": "string"}, {"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-23T18:49:40.185Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "bMudName543","url": "string"}]';

  //print("Response code: " + response.statusCode.toString());
  //print(response.body);

  //if (response.statusCode == 200) {

  var jsonMudData = jsonDecode(test) as List;
  List<MUDData> mudDataListTest =
      jsonMudData.map((tagJson) => MUDData.fromJson(tagJson)).toList();

  return mudDataListTest;

  //} else {
  //throw Exception("Failed to get Data");
  //}
  //TODO bei release auf http request umstellen
}
