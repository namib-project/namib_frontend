import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/roomsGraph.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:graphview/GraphView.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/room.dart';

import 'deviceDetails.dart';

class DevicesGraph extends StatefulWidget {
  const DevicesGraph({
    Key key,
    @required this.room,
    this.devices,
  }) : super(key: key);
  final Room room;
  final List<Device> devices;

  _DeviceGraphState createState() => _DeviceGraphState();
}

class _DeviceGraphState extends State<DevicesGraph> {
  List<Device> _devices = [];
  List<Device> _devicesInRoom = [];
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

  Widget getNodeText(int i) {
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
          child: Text("Node $i")),
    );
  }

  Widget getRoomText(Room room) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                  color: Color(int.parse(room.roomcolor)), spreadRadius: 1),
            ],
          ),
          child: Text(room.roomname)),
      //("Node $i")),
    );
  }

  Widget getDeviceText(Device device){
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              //BoxShadow(color: Color(int.parse(device.roomcolor)), spreadRadius: 1),
            ],
          ),
          child: Column(
            children: [SvgPicture.asset(
              device.clipart, semanticsLabel: 'phone', height: 50, width: 50,
              color: Color(
                int.parse(device.roomcolor),
              ),
            ), Text(device.vendor_class)],
          ) ),
      onTap: () => Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => DeviceDetails(device: device),
        ),
      ),//("Node $i")),
    );
  }

  final Graph graph = Graph();
  Layout builder;

  @override
  void initState() {
    super.initState();

    final Node room = Node(getRoomText(widget.room));

    _devices = widget.devices;
    for (Device d in _devices) {
      if (d.roomname.toLowerCase() == widget.room.roomname.toLowerCase()) {
        _devicesInRoom.add(d);
      }
    }

    _devicesInRoom.forEach((d) {
      final ExtNode device = new ExtNode(getDeviceText(d));
      graph.addEdge(room, device);
    });

    builder = FruchtermanReingoldAlgorithm(iterations: 1000);
  }
}
