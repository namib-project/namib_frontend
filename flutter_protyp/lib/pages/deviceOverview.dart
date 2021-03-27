import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/devicesTable.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'devicesGraph.dart';

// This class returns deviceOverview site with the graphview

class DeviceOverview extends StatefulWidget {
  _DeviceOverviewState createState() => _DeviceOverviewState();
}

class _DeviceOverviewState extends State<DeviceOverview> {

  bool view = true;
 /// URL response to store
  var response;

  /// A List to safe all devices
  Future<List<Device>> devices;

  void changeView() {
    setState(() {
      view = !view;
      pressed = true;
    });
  }

  bool pressed = false;

  @override
  void initState() {
    super.initState();
    devices = getDevices();
  }

  @override
  Widget build(BuildContext context) {
    // Query if device mobile, if not, the graph view will be shown
    if (!pressed) {
      if (!mobileDevice) {
        view = false; //TODO change to true, if graph works
      } else {
        view = false;
      }
      pressed = false;
    }
    return Scaffold(
        appBar: MainAppbar(),
        drawer: MainDrawer(),
        body: Center(
            child: Column(children: [
          // Button to change view between table and graph view
          TextButton.icon(
            icon: Icon(
              Icons.visibility,
              color: buttonColor,
            ),
            label: Text("changeView".tr().toString(),
                style: TextStyle(color: buttonColor)),
            onPressed: () {
              changeView();
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(160, 60)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0))),
            ),
          ),

          TextButton.icon(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(160, 60)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0))),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/deviceOverview");
            },
            label: Text(
              "reload".tr().toString(),
              style: TextStyle(color: buttonColor),
            ),
            icon: Icon(
              Icons.replay,
              color: buttonColor,
            ),
          ),

          // This future builder element put in the different devices after these will be loaded
          // The future builder element a delayed sending of context
          FutureBuilder<List<Device>>(
            future: devices,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (view) {
                  return Expanded(
                      child: DevicesGraph(
                    devices: snapshot.data,
                  ));
                } else {
                  return Expanded(
                      child: DevicesTable(
                    devices: snapshot.data.where((e) => e.type == "managed").toList(),
                  ));
                }
              } else if (snapshot.hasError) {
                // If the process failed this message returns
                print(snapshot.error);
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
        ])));
  }

// Function getting the list of devices in network from controller
  Future<List<Device>> getDevices() async {
    String devicesExtension = 'devices';
    response = await http.get(url + devicesExtension, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      return _handleTimeOut();
    });

    if (response.statusCode == 200) {
      var jsonDevices = jsonDecode(response.body) as List;
      List<Device> devicesTest =
          jsonDevices.map((tagJson) => Device.fromJson(tagJson)).toList();
      return devicesTest;
    } else {
      throw Exception("Failed to get Data");
    }
  }

  dynamic _handleTimeOut() {}
}
