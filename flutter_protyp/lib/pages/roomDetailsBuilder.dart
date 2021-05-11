import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:flutter_protyp/pages/roomDetails.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:http/http.dart' as http;

/// FutureBuilder to load RoomDetails with data

class RoomDetails extends StatefulWidget {
  const RoomDetails({
    Key key,
    @required this.roomId,
  }) : super(key: key);

  final int roomId;

  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  Future<Room> roomFuture;

  @override
  void initState() {
    super.initState();
    roomFuture = fetchRoom();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder<Room>(
        future: roomFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RoomDetailsOverview(
              room: snapshot.data,
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
                      Navigator.pushReplacementNamed(context, "/roomEdit");
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
    );
  }

  /// This function gets the the room with roomId
  Future<Room> fetchRoom() async {
    String roomExtension = "rooms/";

    var _response = await http
        .get(url + roomExtension + widget.roomId.toString(), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    }).timeout(Duration(seconds: 5));

    if (_response.statusCode == 200) {
      String data = utf8.decode(_response.bodyBytes);
      Room roomFormController = Room.fromJson(jsonDecode(data));
      return roomFormController;
    } else {
      return null;
    }
  }

  dynamic _handleTimeOut() {}
}
