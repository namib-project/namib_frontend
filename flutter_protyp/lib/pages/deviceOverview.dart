import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device.dart';
import 'package:flutter_protyp/dataForPresentation/device.dart';
import 'package:flutter_protyp/pages/devicesTable.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:flutter_protyp/graphview/GraphViewClusterPage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:graphview/GraphView.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart' show kIsWeb;

/// returns deviceOverview site
class DeviceOverview extends StatefulWidget {
  _DeviceOverviewState createState() => _DeviceOverviewState();
}

class _DeviceOverviewState extends State<DeviceOverview> {
  bool view = true;
  Future<List<Device>> devices;

  void changeView() {
    setState(() {
      view = !view;
      pressed = true;
    });
  }

  bool pressed = false;

  @override
  void initState() {
    super.initState();
    devices = getDevices();

    List<DeviceForPresentation> devicesforpres =
        new List<DeviceForPresentation>();
    devicesforpres.add(testDevice1);
    devicesforpres.add(testDevice2);
    devicesforpres.add(testDevice3);
    devicesforpres.add(testDevice4);
//
    //List<String> deviceNames = new List<String>();
//
    //devicesforpres.forEach((element) {
    //  deviceNames.add(element.name);
    //  print(element.name);
    //});

    final router = Node(getNodeText(10, "Router"));

    final a = Node(getNodeText(1, devicesforpres[0].systeminfo));
    final b = Node(getNodeText(2, devicesforpres[1].systeminfo));
    final c = Node(getNodeText(3, devicesforpres[2].systeminfo));
    final d = Node(getNodeText(4, devicesforpres[3].systeminfo));

    graph.addEdge(router, a, paint: Paint()..color = Colors.orange);
    graph.addEdge(router, b, paint: Paint()..color = Colors.orange);
    graph.addEdge(router, c, paint: Paint()..color = Colors.orange);
    graph.addEdge(router, d, paint: Paint()..color = Colors.orange);
    builder = FruchtermanReingoldAlgorithm(iterations: 1000);
  }

  @override
  Widget build(BuildContext context) {
    // Query if device mobile, if not, the graph view will be shown
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
              // Button to change view between table and graph view
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
          // This future builder element put in the different devices after these will be loaded
          // The future builder element a delayed sending of context
          FutureBuilder<List<Device>>(
            future: devices,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (view) {
                  return Row(
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
                      ]);
                } else {
                  return Expanded(
                      child: TableTest(
                    devices: snapshot.data,
                  ));
                }
              } else if (snapshot.hasError) {
                // If the process failed this message
                return Container(
                  width: 600,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SelectableText(
                            "Daten konnten nicht geholt werden bitte erneut versuchen"),
                        RaisedButton(
                            child: Text("Neu laden"),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, "/deviceOverview");
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
        ])));
  }

  int n = 8;
  Random r = Random();

  // This method takes the text from the method below and puts in the graph
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

  // Function getting the list of devices in network from controller
  Future<List<Device>> getDevices() async {
    String urlDevices = 'http://172.26.144.1:8000/devices/';
    var responseDevices;
    //responseDevices = await http.get(urlDevices);
    String test = '[{"hostname": "string","id": 0,"ip_addr": "string","last_interaction": "string","mac_addr": "string","mud_data": {"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "ntp.org"},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"},{"ace": [{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "amazon.de"},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-02-05T09:30:26.460Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"},"mud_url": "string","vendor_class": "string"}]';
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
}
