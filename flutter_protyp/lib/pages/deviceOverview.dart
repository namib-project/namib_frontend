//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/tebleTest.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:flutter_protyp/graphview/GraphViewClusterPage.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

/// returns deviceOverview site
class DeviceOverview extends StatefulWidget {
  @override
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
      if (kIsWeb) {
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
              FlatButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                  appBar: AppBar(),
                                  body: GraphClusterViewPage(),
                                )),
                      ),
                  child: Text(
                    "Graph Cluster View (FruchtermanReingold)",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
            if (!view) Expanded(child: TableTest()),
          ]),
        ));
  }
}

//Preferable icon for switching between graph/table
//icon: Icon(Icons.visibility),
