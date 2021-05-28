import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/newDevicesOverview.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:http/http.dart' as http;

/// FutureBuilder to load newDevicesOverview with data

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
    devices = _getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: [
            /// This future builder element put in the different devices after these will be loaded
            /// The future builder element a delayed sending of context
            FutureBuilder<List<Device>>(
              future: devices,
              builder: (context, snapshotDevice) {
                if (snapshotDevice.hasData) {
                  return Expanded(
                    child: NewDevicesTable(
                      devices: snapshotDevice.data
                          .where((e) => e.type == "detecting")
                          .toList(),
                    ),
                  );
                } else if (snapshotDevice.hasError) {
                  /// If the process failed this message returns
                  print(snapshotDevice.error);
                  return Container(
                    width: 600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SelectableText("wentWrongError".tr().toString()),
                        ElevatedButton(
                          child: Text("reload".tr().toString()),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/deviceOverview");
                          },
                        )
                      ],
                    ),
                  );
                }

                /// By default, show a loading spinner.
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

  /// Function getting the list of devices in network from controller
  Future<List<Device>> _getDevices() async {
    String devicesExtension = 'devices';
    var _response = await http.get(Uri.parse(url + devicesExtension), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      return null;
    });

    if (_response.statusCode == 200) {
      var jsonDevices = jsonDecode(_response.body) as List;
      List<Device> devicesTest =
          jsonDevices.map((tagJson) => Device.fromJson(tagJson)).toList();
      return devicesTest;
    } else {
      throw Exception("Failed to get Data");
    }
  }
}
