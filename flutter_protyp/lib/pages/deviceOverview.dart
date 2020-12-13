import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";

import 'package:graphql_flutter/graphql_flutter.dart';

/// returns deviceOverview site
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
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Geräteübersicht",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DeviceListTile(
                      deviceName: "GeräteName1",
                      deviceDescription: "Beschreibung1",
                    ),
                    DeviceListTile(
                      deviceName: "GeräteName2",
                      deviceDescription: "Beschreibung2",
                    ),
                    DeviceListTile(
                      deviceName: "GeräteName3",
                      deviceDescription: "Beschreibung3",
                    ),
                    DeviceListTile(
                      deviceName: "GeräteName4",
                      deviceDescription: "Beschreibung4",
                    ),
                    DeviceListTile(
                      deviceName: "GeräteName5",
                      deviceDescription: "Beschreibung5",
                    ),
                    DeviceListTile(
                      deviceName: "GeräteName6",
                      deviceDescription: "Beschreibung6",
                    ),
                    DeviceListTile(
                      deviceName: "GeräteName7",
                      deviceDescription: "Beschreibung7",
                    ),
                    DeviceListTile(
                      deviceName: "GeräteName8",
                      deviceDescription: "Beschreibung8",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
