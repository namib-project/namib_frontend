import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";

class CreateDevice extends StatefulWidget {
  @override
  _CreateDeviceState createState() => _CreateDeviceState();
}

class _CreateDeviceState extends State<CreateDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Text("CreateDevice"),
      ),
    );
  }
}
