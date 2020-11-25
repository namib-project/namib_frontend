import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";

class CreateMudProfile extends StatefulWidget {
  @override
  _CreateMudProfileState createState() => _CreateMudProfileState();
}

class _CreateMudProfileState extends State<CreateMudProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Text("CreateMudProfile"),
      ),
    );
  }
}
