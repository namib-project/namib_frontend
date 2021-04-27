import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/devicesGraph.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:graphview/GraphView.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/room.dart';

import 'deviceDetails.dart';

class RoomsGraph extends StatefulWidget {
  const RoomsGraph({
    Key key,
    @required this.devices,
  }) : super(key: key);

  /// List which stores all given devices
  final List<Device> devices;

  _RoomsGraphState createState() => _RoomsGraphState();
}

class _RoomsGraphState extends State<RoomsGraph> {
  Future<List<Device>> devices;

  List<Device> _devices = [];
  List<Room> _rooms = [];


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Container(
            child: Column(children: [
          Container(
            height: 70,
            child: SelectableText(
              'deviceOverview'.tr().toString(),
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InteractiveViewer(
                    constrained: true,
                    boundaryMargin: EdgeInsets.all(8),
                    minScale: 0.001,
                    maxScale: 100,
                    child: GraphView(
                      graph: graph,
                      algorithm: builder,
                      paint: Paint()
                        ..color = Colors.green
                        ..strokeWidth = 1
                        ..style = PaintingStyle.fill,
                    )),
              ]),
        ])),
      ),
    );
  }

  // Function getting the list of devices in network from controller
  Future<List<Device>> getDevices() async {
    String urlDevices = 'http://172.26.144.1:8000/devices/';
    var responseDevices;
    //responseDevices = await http.get(urlDevices);
    String test =
        '[{"hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-02-12T07:41:54.362Z","mac_addr": "string","mud_data": {"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-02-12T07:41:54.362Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"},"mud_url": "string","vendor_class": "string","room":"Bath room"}, {"hostname": "string","id": 0,"ip_addr": "string","last_interaction": "2021-02-12T07:41:54.362Z","mac_addr": "string","mud_data": {"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-02-12T07:41:54.362Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"},"mud_url": "string","vendor_class": "string", "room":"Living Room"}]';
    var jsonDevices = jsonDecode(test) as List;
    List<Device> devicesTest =
        jsonDevices.map((tagJson) => Device.fromJson(tagJson)).toList();
    return devicesTest;
    //if (responseDevices.statusCode == 200) {
    //  return devicesTest;
    //} else {
    //  throw Exception("Failed to get Data");
    //}
    //TODO bei release auf http request umstellen
  }

  Widget getNodeText(int i, [Device device, String name, int j]) {
    if (device != null) {
      return GestureDetector(
        onLongPressStart: (details) {
          var x = details.globalPosition.dx;
          var y = details.globalPosition.dy;
          Offset(x, y);
        },
        onPanStart: (details) {
          var x = details.globalPosition.dx;
          var y = details.globalPosition.dy;
          setState(() {
            builder.setFocusedNode(graph.getNodeAtPosition(i - 1));
            graph.getNodeAtPosition(i - 1).position = Offset(x, y);
          });
        },
        onPanUpdate: (details) {
          var x = details.globalPosition.dx;
          var y = details.globalPosition.dy;
          setState(() {
            builder.setFocusedNode(graph.getNodeAtPosition(i - 1));
            graph.getNodeAtPosition(i - 1).position = Offset(x, y);
          });
        },
        onPanEnd: (details) {
          builder.setFocusedNode(null);
        },
        child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(color: Colors.blue[100], spreadRadius: 1),
              ],
            ),
            child: SvgPicture.asset(allClipArts[3],
                semanticsLabel: 'phone', height: 25, width: 25)),
        //
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceDetails(device: device),
          ),
        ), //("Node $i")),
      );
    } else if (j == 13) {
      return GestureDetector(
        onLongPressStart: (details) {
          var x = details.globalPosition.dx;
          var y = details.globalPosition.dy;
          Offset(x, y);
        },
        onPanStart: (details) {
          var x = details.globalPosition.dx;
          var y = details.globalPosition.dy;
          setState(() {
            builder.setFocusedNode(graph.getNodeAtPosition(i - 1));
            graph.getNodeAtPosition(i - 1).position = Offset(x, y);
          });
        },
        onPanUpdate: (details) {
          var x = details.globalPosition.dx;
          var y = details.globalPosition.dy;
          setState(() {
            builder.setFocusedNode(graph.getNodeAtPosition(i - 1));
            graph.getNodeAtPosition(i - 1).position = Offset(x, y);
          });
        },
        onPanEnd: (details) {
          builder.setFocusedNode(null);
        },
        child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(color: Colors.orange, spreadRadius: 1),
              ],
            ),
            child: SvgPicture.asset(allClipArts[j],
                semanticsLabel: 'phone', height: 25, width: 25)),
        //
      );
    } else {
      return GestureDetector(
          onLongPressStart: (details) {
            var x = details.globalPosition.dx;
            var y = details.globalPosition.dy;
            Offset(x, y);
          },
          onPanStart: (details) {
            var x = details.globalPosition.dx;
            var y = details.globalPosition.dy;
            setState(() {
              builder.setFocusedNode(graph.getNodeAtPosition(i - 1));
              graph.getNodeAtPosition(i - 1).position = Offset(x, y);
            });
          },
          onPanUpdate: (details) {
            var x = details.globalPosition.dx;
            var y = details.globalPosition.dy;
            setState(() {
              builder.setFocusedNode(graph.getNodeAtPosition(i - 1));
              graph.getNodeAtPosition(i - 1).position = Offset(x, y);
            });
          },
          onPanEnd: (details) {
            builder.setFocusedNode(null);
          },
          child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(color: Colors.orange, spreadRadius: 1),
                ],
              ),
              child: Text(name)) //("Node $i")),
          );
    }
  }

  Widget getRooterText(){
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.orange),
            ],
          ),
          child: SvgPicture.asset(allClipArts[13],
              semanticsLabel: 'phone', height: 35, width: 35)),
    );
  }


  Widget getRoomText(Room room, List<Device> devices){
      return GestureDetector(
          child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(color: Color(int.parse(room.roomcolor)), spreadRadius: 1),
                ],
              ),
              child: Text(room.roomname)),
           onTap: () => Navigator.push(context,
               MaterialPageRoute(
               builder: (context) => DevicesGraph(room: room, devices: devices),
            ),
           ),//("Node $i")),
      );
    }

  final Graph graph = Graph();
  Layout builder;

  @override
  void initState() {
    super.initState();
    final Node router = Node(getRooterText());


    _devices = widget.devices;
    for(Device d in _devices){
      Room room = new Room(d.roomname, d.roomcolor);
      _rooms.add(room);
    }
    final _allRooms = _rooms.map((e) => e.roomname).toSet();
    _rooms.retainWhere((x) => _allRooms.remove(x.roomname));

    _rooms.forEach((Room r) {
      final ExtNode room = new ExtNode(getRoomText(r, _devices));
      graph.addEdge(router, room, paint: Paint()..color = Colors.orange);
    });

    builder = FruchtermanReingoldAlgorithm(iterations: 10000);
  }
}

class ExtNode extends Node{

  ExtNode(Widget data) : super(data);

  String get name => name;

  set name (String name){
    this.name = name;
  }

}
