import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/tebleTest.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";

import 'package:flutter_protyp/graphview/LayerGraphView.dart';
import 'package:flutter_protyp/graphview/GraphViewClusterPage.dart';
import 'package:flutter_protyp/graphview/TreeViewPage.dart';
import 'package:easy_localization/easy_localization.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {
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

/// All this probably has to be changed, when connection to controller is established
/// Gives a Tile for list of deviceOverview
class DeviceListTile extends StatefulWidget {
  final String deviceName;
  final String deviceDescription;

  const DeviceListTile({Key key, this.deviceName, this.deviceDescription})
      : super(key: key);

  @override
  _DeviceListTileState createState() => _DeviceListTileState();
}

class _DeviceListTileState extends State<DeviceListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[400],
            ),
          ),
        ),
        child: Container(
          height: 100,
          width: 1000,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.deviceName,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                widget.deviceDescription,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Icon(Icons.delete),
              Icon(Icons.settings),
            ],
          ),
        ),
      ),
    );
  }
}

//Preferable icon for switching between graph/table
//icon: Icon(Icons.visibility),
