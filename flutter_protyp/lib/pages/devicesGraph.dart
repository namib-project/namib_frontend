import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/dataForPresentation/device.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:graphview/GraphView.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:easy_localization/easy_localization.dart';

import 'deviceDetails.dart';

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
        '[{"hostname": "string","id": 0,"ip_addr": "string","last_interaction": "string","mac_addr": "string","mud_data": {"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "ntp.org"},"name": "string"},{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "weather.com"},"name": "string"},{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice", "dnsname": "xyz.media"},"name": "string"},{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "storage.de"},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-01-23T10:35:17.609Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"},"mud_url": "string","vendor_class": "string"}, {"hostname": "string","id": 0,"ip_addr": "string","last_interaction": "string","mac_addr": "string","mud_data": {"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "string"},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-01-17T21:05:00.692Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"},"mud_url": "string","vendor_class": "string"}]';
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


  Widget getNodeText([Device device, String name]) {
    if (device != null) {
      return GestureDetector(
        child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(color: Colors.blue[100], spreadRadius: 1),
              ],
            ),
            child: WebsafeSvg.asset(allClipArts[3],
                semanticsLabel: 'phone', height: 25, width: 25)), //
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceDetails(device: device),
          ),
        ), //("Node $i")),
      );
    } else {
      return GestureDetector(
          child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(color: Colors.blue[100], spreadRadius: 1),
                ],
              ),
              child: Text(name)) //("Node $i")),
          );
    }
  }

  final Graph graph = Graph();
  Layout builder;



  void initStat() {
    List<Device> devices = getDevices() as List<Device>;

    final router = Node(getNodeText(null, "Router"));

    List<String> rooms = new List();
    List<Node> roomNodes = new List();

    devices.forEach((element) {
      if (!rooms.contains(element.room)) rooms.add(element.room);
    });

    rooms.forEach((element) {
      Node room = new Node(getNodeText(null, element));
      room.name = element;
      graph.addEdge(router, room, paint: Paint()..color = Colors.orange);
      roomNodes.add(room);
    });

    devices.forEach((elementDevice) {
      Node device = new Node(getNodeText(elementDevice));
      roomNodes.forEach((elementRoom) {
        if(elementRoom.name == elementDevice.room){
          graph.addEdge(elementRoom, device, paint: Paint()..color = Colors.orange);
        }
      });
    });

    builder = FruchtermanReingoldAlgorithm(iterations: 10000);
  }
}
