import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:http/http.dart' as http;

import 'editRoom.dart';

class EditRoom extends StatefulWidget {
  _EditRoomState createState() => _EditRoomState();
}

/// Class for getting the rooms from controller
class _EditRoomState extends State<EditRoom> {
  /// List stores rooms
  Future<List<Room>> rooms;

  @override
  void initState() {
    super.initState();
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
            /// Future Builder for getting the rooms
            FutureBuilder<List<Room>>(
              future: rooms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: EditRoomTable(
                    rooms: snapshot.data,
                  ));
                } else if (snapshot.hasError) {
                  /// If the process failed this message returns
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
                                    context, "/editRoom");
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

  /// Function gets rooms from controller
  Future<List<Room>> getRooms() async {
    String roomsExtension = 'rooms';
    var _response = await http.get(Uri.parse(url + roomsExtension), headers: {
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

  dynamic _handleTimeOut() {}
}
