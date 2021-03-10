
// This class is not be used

import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";

class Networkbehaviour extends StatefulWidget {
  @override
  _NetworkbehaviourState createState() => _NetworkbehaviourState();
}

class _NetworkbehaviourState extends State<Networkbehaviour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Text("Networkbehaviour"),
      ),
    );
  }
}
