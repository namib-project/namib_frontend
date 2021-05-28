import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:flutter_protyp/pages/deviceDetailsBuilder.dart';
import 'package:flutter_protyp/pages/roomsGraph.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:graphview/GraphView.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'deviceDetails.dart';

/// This class generates the graph for a specific room

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
  /// Lists to store information about the devices and rooms
  List<Device> _devices = [];
  List<Device> _devicesInRoom = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: SelectableText(widget.room.name),
        actions: <Widget>[
          Padding(
            padding: mobileDevice
                ? EdgeInsets.fromLTRB(12, 5, 12, 12)
                : EdgeInsets.fromLTRB(0, 5, 12, 12),
            child: SettingsPopup(),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              child: Column(children: [
            Container(
              height: 70,
              child: SelectableText(
                widget.room.name,
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
      ),
    );
  }

  /// Function to generate a node for a room
  Widget getRoomText(Room room) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Color(int.parse(room.color)), spreadRadius: 1),
            ],
          ),
          child: Text(room.name)),
      //("Node $i")),
    );
  }

  /// Function to generate a node for a device
  Widget getDeviceText(Device device) {
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
            children: [
              SvgPicture.asset(
                device.clipart,
                semanticsLabel: 'phone',
                height: 50,
                width: 50,
                color: Color(
                  int.parse(device.room.color),
                ),
              ),
              Text(device.hostname)
            ],
          )),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeviceDetailsBuilder(
            id: device.id,
          ),
        ),
      ), //("Node $i")),
    );
  }

  final Graph graph = Graph();
  Layout builder;

  @override
  void initState() {
    super.initState();

    /// Node for the current room
    final Node room = Node(getRoomText(widget.room));

    /// Gets all devices in the current room
    _devices = widget.devices;
    for (Device d in _devices) {
      if (d.room.name.toLowerCase() == widget.room.name.toLowerCase()) {
        _devicesInRoom.add(d);
      }
    }

    /// Generates all nodes and edges for all devices in the current room
    _devicesInRoom.forEach((d) {
      final ExtNode device = new ExtNode(getDeviceText(d));
      graph.addEdge(room, device, paint: Paint()..color = Colors.orange);
    });

    builder = FruchtermanReingoldAlgorithm(iterations: 1000);
  }
}
