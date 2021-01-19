//import 'dart:html';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device.dart';
import 'package:flutter_protyp/dataForPresentation/device.dart';
import 'package:flutter_protyp/pages/tebleTest.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:flutter_protyp/graphview/GraphViewClusterPage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graphview/GraphView.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

/// returns deviceOverview site
class DeviceOverview extends StatefulWidget {
  const DeviceOverview({
    Key key,
    @required this.devices,
  }) : super(key: key);
  final List<Device> devices;

  _DeviceOverviewState createState() => _DeviceOverviewState();
}

class _DeviceOverviewState extends State<DeviceOverview> {
  bool view = true;

  void changeView() {
    setState(() {
      view = !view;
      pressed = true;
    });
  }

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    if (!pressed) {
      if (!mobileDevice) {
        view = true;
      } else {
        view = false;
      }
      pressed = false;
    }
    return Scaffold(
        appBar: MainAppbar(),
        drawer: MainDrawer(),
        body: Center(
          child: Column(children: [
            FlatButton(
              onPressed: () {
                changeView();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                width: 200,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.visibility),
                    SizedBox(
                      width: 15,
                    ),
                    Text("changeView".tr().toString())
                  ],
                ),
              ),
            ),
            if (view)
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
            //FlatButton(
            //    onPressed: () => Navigator.push(
            //          context,
            //          MaterialPageRoute(
            //              builder: (context) => Scaffold(
            //                    appBar: AppBar(),
            //                    body: GraphClusterViewPage(),
            //                  )),
            //        ),
            //    child: Text(
            //      "Graph Cluster View (FruchtermanReingold)",
            //      style: TextStyle(color: Theme.of(context).primaryColor),
            //    )),
            if (!view)
              Expanded(
                  child: TableTest(
                devices: widget.devices,
              )),
          ]),
        ));
  }

  int n = 8;
  Random r = Random();

  Widget getNodeText(int i, String name) {
    return GestureDetector(
        //onLongPressStart: (details) {
        //  var x = details.globalPosition.dx;
        //  var y = details.globalPosition.dy;
        //  Offset(x, y);
        //},
        //onPanStart: (details) {
        //  var x = details.globalPosition.dx;
        //  var y = details.globalPosition.dy;
        //  setState(() {
        //    builder.setFocusedNode(graph.getNodeAtPosition(i - 1));
        //    graph.getNodeAtPosition(i - 1).position = Offset(x, y);
        //  });
        //},
        //onPanUpdate: (details) {
        //  var x = details.globalPosition.dx;
        //  var y = details.globalPosition.dy;
        //  setState(() {
        //    builder.setFocusedNode(graph.getNodeAtPosition(i - 1));
        //    graph.getNodeAtPosition(i - 1).position = Offset(x, y);
        //  });
        //},
        //onPanEnd: (details) {
        //  builder.setFocusedNode(null);
        //},
        child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(color: Colors.blue[100], spreadRadius: 1),
              ],
            ),
            child: Text(name)) //Icon(Icons.device_unknown))
        //("Node $i")),
        );
  }

  final Graph graph = Graph();
  Layout builder;

  @override
  void initState() {
    List<DeviceForPresentation> devices = new List<DeviceForPresentation>();
    devices.add(testDevice1);
    devices.add(testDevice2);
    devices.add(testDevice3);
    devices.add(testDevice4);
//
    //List<String> deviceNames = new List<String>();
//
    //devices.forEach((element) {
    //  deviceNames.add(element.name);
    //  print(element.name);
    //});

    final router = Node(getNodeText(10, "Router"));

    final a = Node(getNodeText(1, devices[0].systeminfo));
    final b = Node(getNodeText(2, devices[1].systeminfo));
    final c = Node(getNodeText(3, devices[2].systeminfo));
    final d = Node(getNodeText(4, devices[3].systeminfo));

    graph.addEdge(router, a, paint: Paint()..color = Colors.orange);
    graph.addEdge(router, b, paint: Paint()..color = Colors.orange);
    graph.addEdge(router, c, paint: Paint()..color = Colors.orange);
    graph.addEdge(router, d, paint: Paint()..color = Colors.orange);
    builder = FruchtermanReingoldAlgorithm(iterations: 1000);
  }
}

//Preferable icon for switching between graph/table
//icon: Icon(Icons.visibility),
