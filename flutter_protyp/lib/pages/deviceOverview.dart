import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";

class DeviceOverview extends StatefulWidget {
  @override
  _DeviceOverviewState createState() => _DeviceOverviewState();
}

class _DeviceOverviewState extends State<DeviceOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Text("DeviceOverview"),
      ),
    );
  }
}
