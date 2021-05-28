import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:flutter_protyp/pages/devicesTable.dart';
import 'package:flutter_protyp/pages/handlers/ThemeChangeHandler.dart';
import 'package:flutter_protyp/pages/roomsGraph.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

/// This class returns deviceOverview site with the graphview

class DeviceOverview extends StatefulWidget {
  _DeviceOverviewState createState() => _DeviceOverviewState();
}

class _DeviceOverviewState extends State<DeviceOverview> {
  /// A List to safe all devices
  Future<List<Device>> devices;
  Future<List<Room>> rooms;

  void changeView() {
    setState(() {
      view = !view;
    });

    ThemeChangeHandler handler = ThemeChangeHandler();
    handler.setViewUserConfig(view);
  }

  @override
  void initState() {
    super.initState();
    devices = getDevices();
    rooms = getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: [
            /// Button to change view between table and graph view
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

            /// This future builder element put in the different devices after these will be loaded
            /// The future builder element a delayed sending of context
            FutureBuilder<List<Room>>(
              future: rooms,
              builder: (context, snapshotRoom) {
                if (snapshotRoom.hasData) {
                  return FutureBuilder<List<Device>>(
                    future: devices,
                    builder: (context, snapshotDevice) {
                      if (snapshotDevice.hasData) {
                        snapshotDevice.data.forEach((element) {
                          if(element.room == null){
                            element.room = Room.roomConstructor(-1, 'notAssigned'.tr().toString(), "0xFFB00020");
                          }
                        });

                        if (view) {
                          return Expanded(
                              child: RoomsGraph(
                            devices: snapshotDevice.data
                                .where((e) => e.type == "managed")
                                .toList(),
                          ));
                        } else {
                          return Expanded(
                              child: DevicesTable(
                            rooms: snapshotRoom.data,
                            devices: snapshotDevice.data
                                .where((e) => e.type == "managed")
                                .toList(),
                          ));
                        }
                      } else if (snapshotDevice.hasError) {
                        /// If the process failed error message returns
                        print(snapshotDevice.error);
                        return Container(
                          width: 600,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                SelectableText(
                                    "wentWrongError".tr().toString()),
                                ElevatedButton(
                                    child: Text("reload".tr().toString()),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, "/deviceOverview");
                                    })
                              ]),
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
                  );
                } else if (snapshotRoom.hasError) {
                  /// If the process failed this message returns
                  print(snapshotRoom.error);
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
  Future<List<Device>> getDevices() async {
    String devicesExtension = 'devices';
    var _response = await http.get(url + devicesExtension, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      return _handleTimeOut();
    });

    if (_response.statusCode == 200) {
      String data = utf8.decode(_response.bodyBytes);
      var jsonDevices = jsonDecode(data) as List;
      List<Device> devicesTest =
          jsonDevices.map((tagJson) => Device.fromJson(tagJson)).toList();
      return devicesTest;
    } else {
      throw Exception("Failed to get Data");
    }
  }

  /// Function getting the list of rooms in network from controller
  Future<List<Room>> getRooms() async {
    String roomsExtension = 'rooms';
    var _response = await http.get(url + roomsExtension, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      return _handleTimeOut();
    });

    if (_response.statusCode == 200) {
      String data = utf8.decode(_response.bodyBytes);
      var jsonRooms = jsonDecode(data) as List;
      List<Room> roomsTest =
          jsonRooms.map((tagJson) => Room.fromJson(tagJson)).toList();
      return roomsTest;
    } else {
      throw Exception("Failed to get Data");
    }
  }

  /// Timeout function
  dynamic _handleTimeOut() {}
}
