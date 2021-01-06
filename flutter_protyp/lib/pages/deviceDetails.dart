import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/drawer.dart';


class DeviceDetails extends StatefulWidget {
  @override
  _DeviceDetailsState createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Row(
            children: <Widget>[SelectableText("Details"),],//Image
          ),
          Center(
            child: Row(
              children: <Widget>[
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 16,
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          SelectableText("IP-Adresse: 192.168.1.2"),

                        ],
                      )
                  ),
                ),
                Expanded(flex: 1, child: Container())
              ],
            ),
          ),
        ],
      ),
    );
  }
}