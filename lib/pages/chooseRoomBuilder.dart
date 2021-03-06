import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/data/device_mud/mudGuess.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:flutter_protyp/pages/chooseRoom.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:http/http.dart' as http;

/// This class builds ingredients for chooseRoom.dart

class ChooseRoom extends StatefulWidget {
  ChooseRoom({
    Key key,
    @required this.device,
    @required this.mudGuesses,
  }) : super(key: key);

  /// Creates a device
  final Device device;

  /// A MUD-Guesses list
  final List<MudGuess> mudGuesses;

  _ChooseRoomState createState() => _ChooseRoomState();
}

class _ChooseRoomState extends State<ChooseRoom> {
  /// List with rooms
  Future<List<Room>> rooms;

  @override
  void initState() {
    super.initState();
    rooms = getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            /// This future builder element put in the different devices after these will be loaded
            /// The future builder element a delayed sending of context
            FutureBuilder<List<Room>>(
              future: rooms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: RoomTable(
                        rooms: snapshot.data,
                        device: widget.device,
                        mudGuesses: widget.mudGuesses),
                  );
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
                                context, "/chooseRoom");
                          },
                        ),
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

  /// This gets the rooms from the server
  Future<List<Room>> getRooms() async {
    String roomsExtension = 'rooms';

    var _response = await http.get(Uri.parse(url + roomsExtension), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      return _handleTimeOut();
    });

    if (_response.statusCode == 200) {
      String _data = utf8.decode(_response.bodyBytes);
      var jsonRooms = jsonDecode(_data) as List;
      List<Room> roomsTest =
          jsonRooms.map((tagJson) => Room.fromJson(tagJson)).toList();
      return roomsTest;
    } else {
      throw Exception("Failed to get Data");
    }
  }

  dynamic _handleTimeOut() {}
}
