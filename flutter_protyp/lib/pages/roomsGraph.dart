import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:flutter_protyp/pages/devicesGraph.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:graphview/GraphView.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

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

/// This class generates the graph for all rooms
class _RoomsGraphState extends State<RoomsGraph> {
  Future<List<Device>> devices;

  List<Device> _devices = [];
  List<Room> _rooms = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Function to generate a node for the router
  Widget getRooterText() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.orange),
          ],
        ),
        child: SvgPicture.asset(
          allClipArts[13],
          semanticsLabel: 'phone',
          height: 35,
          width: 35,
        ),
      ),
    );
  }

  /// Function to generate a node for a room
  Widget getRoomText(Room room, List<Device> devices) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Color(
                int.parse(
                  room.color,
                ),
              ),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          room.name,
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DevicesGraph(
            room: room,
            devices: devices,
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

    /// Node for the router
    final Node router = Node(getRooterText());

    /// gets all rooms
    _devices = widget.devices;
    for (Device d in _devices) {
      Room room = new Room(d.room.id, d.room.name, d.room.color);
      _rooms.add(room);
    }
    final _allRooms = _rooms.map((e) => e.name).toSet();
    _rooms.retainWhere((x) => _allRooms.remove(x.name));

    /// generates all nodes and edges for all rooms
    _rooms.forEach((Room r) {
      final ExtNode room = new ExtNode(getRoomText(r, _devices));
      graph.addEdge(router, room, paint: Paint()..color = Colors.orange);
    });

    builder = FruchtermanReingoldAlgorithm(iterations: 10000);
  }
}

class ExtNode extends Node {
  ExtNode(Widget data) : super(data);

  String get name => name;

  set name(String name) {
    this.name = name;
  }
}
