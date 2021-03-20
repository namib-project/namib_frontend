import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/newDevicesTable.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

/// returns deviceOverview site
class NewDeviceOverview extends StatefulWidget {
  _NewDeviceOverviewState createState() => _NewDeviceOverviewState();
}

class _NewDeviceOverviewState extends State<NewDeviceOverview> {
  var response;

  /// A List to safe all devices
  Future<List<Device>> devices;

  bool pressed = false;

  @override
  void initState() {
    super.initState();
    devices = getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppbar(),
        drawer: MainDrawer(),
        body: Center(
            child: Column(children: [
          // This future builder element put in the different devices after these will be loaded
          // The future builder element a delayed sending of context
          FutureBuilder<List<Device>>(
            future: devices,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: NewDevicesTable(
                    devices: snapshot.data,
                  ),
                );
              } else if (snapshot.hasError) {
                // If the process failed this message returns
                print(snapshot.error);
                return Container(
                  width: 600,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SelectableText(
                        "wentWrongError".tr().toString(),
                      ),
                      RaisedButton(
                          child: Text(
                            "reload".tr().toString(),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/newDeviceOverview");
                          })
                    ],
                  ),
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
        ])));
  }
}

// Function getting the list of devices in network from controller
Future<List<Device>> getDevices() async {
  // String devicesExtension = 'devices';
  // response = await http.get(url + devicesExtension, headers: {
  //   "Content-Type": "application/json",
  //   "Authorization": "Bearer $jwtToken"
  // }).timeout(const Duration(seconds: 5), onTimeout: () {
  //   return _handleTimeOut();
  // });

  String test =
      '[{"roomname": "Küche", "roomcolor": "0xFF6200EE", "clipart": "resources/clipart/cloud.svg","hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-03-19T08:50:26.205Z","mac_addr": "string","mud_data": {"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "www.google.de","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-19T08:50:26.205Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "adevice123","url": "string"},"mud_url": "string","vendor_class": "string"},{"roomname": "Bad", "roomcolor": "0xFFB00020", "clipart": "resources/clipart/desktop_windows.svg","hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-03-19T08:50:26.205Z","mac_addr": "string","mud_data": {"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "www.facebook.com","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-19T08:50:26.205Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "bdevice345","url": "string"},"mud_url": "string","vendor_class": "string"}, {"roomname": "Bad", "roomcolor": "0xFFB00020", "clipart": "resources/clipart/sun.svg","hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-03-19T08:50:26.205Z","mac_addr": "string","mud_data": {"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "www.facebook.com","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-19T08:50:26.205Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "cdevice567","url": "string"},"mud_url": "string","vendor_class": "string"}]';

  //print("Response code: " + response.statusCode.toString());
  //print(response.body);

  //if (response.statusCode == 200) {
  var jsonDevices = jsonDecode(test) as List;
  List<Device> devicesTest =
      jsonDevices.map((tagJson) => Device.fromJson(tagJson)).toList();
  return devicesTest;
  //} else {
  //throw Exception("Failed to get Data");
  //}
  //TODO bei release auf http request umstellen
}

dynamic _handleTimeOut() {}
