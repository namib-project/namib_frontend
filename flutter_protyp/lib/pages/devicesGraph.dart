import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:graphview/GraphView.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'deviceDetailsBuilder.dart';

// This class implements the functions to generate the devices-graph

class DevicesGraph extends StatefulWidget {
  const DevicesGraph({
    Key key,
    @required this.devices,
  }) : super(key: key);

  /// List which stores all given devices
  final List<Device> devices;

  _DevicesGraphState createState() => _DevicesGraphState();
}

class _DevicesGraphState extends State<DevicesGraph> {
  Future<List<Device>> devices;

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
            child: WebsafeSvg.asset(allClipArts[3],
                semanticsLabel: 'phone', height: 25, width: 25)),
        //
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceDetailsBuilder(id: device.id,),
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
            child: WebsafeSvg.asset(allClipArts[j],
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

  final Graph graph = Graph();
  Layout builder;

  @override
  void initState() {
    super.initState();
    int i = 1;
    final router = Node(getNodeText(i, null, "Router", 13));
    final test = Node(getNodeText(2, null, "Beispiel Raum"));
    final deviceTest = Node(getNodeText(3, widget.devices[0]));
    final deviceTest2 = Node(getNodeText(4, widget.devices[1]));
    final exampleRoom = Node(getNodeText(5, null, "Küche"));
    final exampleRoom2 = Node(getNodeText(6, null, "Badezimmer"));
    i++;
    graph.addEdge(router, test, paint: Paint()..color = Colors.black);
    graph.addEdge(test, deviceTest, paint: Paint()..color = Colors.black);
    graph.addEdge(test, deviceTest2, paint: Paint()..color = Colors.black);
    graph.addEdge(router, exampleRoom, paint: Paint()..color = Colors.black);
    graph.addEdge(router, exampleRoom2, paint: Paint()..color = Colors.black);
    //List<String> rooms = new List();
    //List<Node> roomNodes = new List();

    //widget.devices.forEach((element) {
    //  if (!rooms.contains(element.room)) rooms.add(element.room);
    //});

    //rooms.forEach((element) {
    //  final Node room = new Node(getNodeText(i, null, element));
    //  i++;
    //  room.name = element;
    //  graph.addEdge(router, room, paint: Paint()..color = Colors.orange);
    //  roomNodes.add(room);
    //});
    //widget.devices.forEach((elementDevice) {
    //  Node device = new Node(getNodeText(i, elementDevice));
    //  i++;
    //  roomNodes.forEach((elementRoom) {
    //    if (elementRoom.name == elementDevice.room) {
    //      graph.addEdge(elementRoom, device,
    //          paint: Paint()..color = Colors.orange);
    //    }
    //  });
    //});

    //int _deviceCount = widget.devices.length;
    //for(int j = 0; j < _deviceCount; j++){
    //  if(!rooms.contains(widget.devices[j])){
    //    rooms.add(widget.devices[j].room);
    //  }
    //}
    //int _roomCount = rooms.length;
    //for(int j = 0; j < _roomCount; j++){
    //  Node room = new Node(getNodeText(i, null, rooms[j]));
    //  i++;
    //  room.name = rooms[j];
    //  graph.addEdge(router, room);
    //  roomNodes.add(room);
    //}
    //int _roomNodes = roomNodes.length;
    //for(int j = 0; j < _deviceCount; j++){
    //  Node device = new Node(getNodeText(i, widget.devices[j]));
    //  i++;
    //  for(int k = 0; k < _roomNodes; k++){
    //    if (roomNodes[k].name == widget.devices[j].room){
    //      graph.addEdge(roomNodes[k], device);
    //    }
    //  }
    //}

    builder = FruchtermanReingoldAlgorithm(iterations: 10000);
  }
}
