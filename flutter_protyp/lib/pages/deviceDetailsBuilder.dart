import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:flutter_protyp/pages/deviceDetails.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:http/http.dart' as http;

/// This class is just for fetching the data and passes them to deviceDetails

class DeviceDetailsBuilder extends StatefulWidget {
  const DeviceDetailsBuilder({
    Key key,
    @required this.id,
  }) : super(key: key);

  /// Required attribute for fetching the the device from controller
  final int id;

  _DeviceDetailsBuilderState createState() => _DeviceDetailsBuilderState();
}

class _DeviceDetailsBuilderState extends State<DeviceDetailsBuilder> {
  /// Future lists of the data that cones from the controller
  Future<Device> deviceFuture;
  Future<List<Room>> _futureRooms;

  @override
  void initState() {
    super.initState();
    deviceFuture = _fetchDevice();
    _futureRooms = _getRooms();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder<List<Room>>(
        future: _futureRooms,
        builder: (context, _roomsSnapshot) {
          if (_roomsSnapshot.hasData) {
            return FutureBuilder<Device>(
              /// FutureBuilder for processing the future data
              future: deviceFuture,
              builder: (context, _deviceSnapshot) {
                if (_deviceSnapshot.hasData) {
                  return DeviceDetails(
                    device: _deviceSnapshot.data,
                    rooms: _roomsSnapshot.data,
                  );
                } else if (_deviceSnapshot.hasError) {
                  /// If the process failed this message returns
                  print(_deviceSnapshot.error);
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
            );
          } else if (_roomsSnapshot.hasError) {
            /// If the process failed this message returns
            print(_roomsSnapshot.error);
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
    );
  }

  /// This function gets the device from the controller
  Future<Device> _fetchDevice() async {
    String deviceExtension = "devices/";

    var _response = await http.get(url + deviceExtension + widget.id.toString(),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        });
    if (_response.statusCode == 200) {
      String data = utf8.decode(_response.bodyBytes);
      Device deviceFormController = Device.fromJson(jsonDecode(data));

      if (deviceFormController.room == null) {
        deviceFormController.room =
            Room(-1, "notAssigned".tr().toString(), "0xFFB00020");
      }
      if (deviceFormController.clipart == null) {
        deviceFormController.clipart = allClipArts[0];
      }

      return deviceFormController;
    } else {
      return null;
    }
  }

  /// This function gets the rooms from the controller
  Future<List<Room>> _getRooms() async {
    String roomsExtension = 'rooms';
    var _response = await http.get(url + roomsExtension, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      return null;
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
}
