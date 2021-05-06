import 'package:flutter/material.dart';

import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'editRoom.dart';

class EditRoom extends StatefulWidget {
  _EditRoomState createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  Future<List<Room>> rooms;

  var response;

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
            // This future builder element put in the different devices after these will be loaded
            // The future builder element a delayed sending of context
            FutureBuilder<List<Room>>(
              future: rooms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: EditRoomTable(
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
                          ElevatedButton(
                              child: Text("reload".tr().toString()),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, "/editRoom");
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

  Future<List<Room>> getRooms() async {
    String roomsExtension = 'rooms';
    response = await http.get(url + roomsExtension, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      return _handleTimeOut();
    });

    if (response.statusCode == 200) {
      String data = utf8.decode(response.bodyBytes);
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
