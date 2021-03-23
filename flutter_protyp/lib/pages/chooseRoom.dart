import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/roomTable.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_protyp/data/room.dart';
import 'package:easy_localization/easy_localization.dart';

import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseRoom extends StatefulWidget {
  _ChooseRoomState createState() => _ChooseRoomState();
}

class _ChooseRoomState extends State<ChooseRoom> {
  Future<List<Room>> rooms;

  @override
  void initState() {
    super.initState();
    rooms = getRooms();
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
            FutureBuilder<List<Room>>(
              future: rooms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: RoomTable(
                    rooms: snapshot.data,
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
Future<List<Room>> getRooms() async {
  // String devicesExtension = 'devices';
  // response = await http.get(url + devicesExtension, headers: {
  //   "Content-Type": "application/json",
  //   "Authorization": "Bearer $jwtToken"
  // }).timeout(const Duration(seconds: 5), onTimeout: () {
  //   return _handleTimeOut();
  // });

  String test =
      '[{"roomname": "Küche", "roomcolor": "0xFF6200EE", "clipart": "resources/clipart/cloud.svg","hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-03-19T08:50:26.205Z","mac_addr": "string","mud_data": {"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "www.google.de","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-19T08:50:26.205Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "adevice123","url": "string"},"mud_url": "string","vendor_class": "string"}, {"roomname": "Flur", "roomcolor": "0xFFCF6679", "clipart": "resources/clipart/lamp.svg","hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-03-19T08:50:26.205Z","mac_addr": "string","mud_data": {"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "www.google.de","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-19T08:50:26.205Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "bdevice345","url": "string"},"mud_url": "string","vendor_class": "string"}, {"roomname": "Flur", "roomcolor": "0xFFCF6679", "clipart": "resources/clipart/laptop.svg","hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-03-19T08:50:26.205Z","mac_addr": "string","mud_data": {"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "www.google.de","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-19T08:50:26.205Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "cdevice546","url": "string"},"mud_url": "string","vendor_class": "string"}, {"roomname": "Bad", "roomcolor": "0xFF03DAC6", "clipart": "resources/clipart/lightning.svg","hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-03-19T08:50:26.205Z","mac_addr": "string","mud_data": {"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "www.google.de","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-19T08:50:26.205Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "ddevice565","url": "string"},"mud_url": "string","vendor_class": "string"}, {"roomname": "Bad", "roomcolor": "0xFF03DAC6", "clipart": "resources/clipart/music_note_beamed.svg","hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-03-19T08:50:26.205Z","mac_addr": "string","mud_data": {"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "www.google.de","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-19T08:50:26.205Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "edevice453","url": "string"},"mud_url": "string","vendor_class": "string"}, {"roomname": "Flur", "roomcolor": "0xFFCF6679", "clipart": "resources/clipart/phone_iphone.svg","hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-03-19T08:50:26.205Z","mac_addr": "string","mud_data": {"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "www.google.de","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-19T08:50:26.205Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "fdevice546","url": "string"},"mud_url": "string","vendor_class": "string"}, {"roomname": "Flur", "roomcolor": "0xFFCF6679", "clipart": "resources/clipart/router.svg","hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-03-19T08:50:26.205Z","mac_addr": "string","mud_data": {"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "www.google.de","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-19T08:50:26.205Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "gdevice432","url": "string"},"mud_url": "string","vendor_class": "string"}, {"roomname": "Bad", "roomcolor": "0xFF03DAC6", "clipart": "resources/clipart/speaker.svg","hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-03-19T08:50:26.205Z","mac_addr": "string","mud_data": {"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "www.google.de","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-19T08:50:26.205Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "hdevice789","url": "string"},"mud_url": "string","vendor_class": "string"}]';

  //print("Response code: " + response.statusCode.toString());
  //print(response.body);

  //if (response.statusCode == 200) {

  var jsonRooms = jsonDecode(test) as List;
  List<Room> roomsTest =
      jsonRooms.map((tagJson) => Room.fromJson(tagJson)).toList();
  return roomsTest;

  //} else {
  //throw Exception("Failed to get Data");
  //}
  //TODO bei release auf http request umstellen
}
