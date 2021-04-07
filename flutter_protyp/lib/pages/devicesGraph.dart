import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:graphview/GraphView.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/room.dart';

import 'deviceDetails.dart';

class DevicesGraph extends StatefulWidget{

  const DevicesGraph({
    Key key,
    @required this.room,
}) : super(key: key);
  final Room room;

  _DeviceGraphState createState() => _DeviceGraphState();
}



class _DeviceGraphState extends State<DevicesGraph>{
  @override
  void initState(){
    super.initState();
    final a = Node(getNodeText(1));
    final b = Node(getNodeText(2));
    final c = Node(getNodeText(3));
    final d = Node(getNodeText(4));
    final e = Node(getNodeText(5));
    final f = Node(getNodeText(6));
    final g = Node(getNodeText(7));
    final h = Node(getNodeText(8));

    graph.addEdge(a, b, paint: Paint()..color = Colors.red);
    graph.addEdge(a, c);
    graph.addEdge(a, d);
    graph.addEdge(c, e);
    graph.addEdge(d, f);
    graph.addEdge(f, c);
    graph.addEdge(g, c);
    graph.addEdge(h, g);

    builder = FruchtermanReingoldAlgorithm(iterations: 1000);
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

  final Graph graph = Graph();
  Layout builder;

}
