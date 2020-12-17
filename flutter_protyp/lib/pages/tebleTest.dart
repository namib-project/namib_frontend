import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/widgets/appbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TableTest extends StatefulWidget {
  @override
  _TableTestState createState() => _TableTestState();
}

//Class for user registration, will only be used at the first usage
class _TableTestState extends State<TableTest> {
  List<DataRow> list = [];
  bool sortFirstRow = false;

  @override
  void initState() {
    //_generateTableRows();
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MainAppbar(),
        drawer: MainDrawer(),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                children: [
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
                  DataTable(
                    onSelectAll: (b){},
                      sortColumnIndex: 0,
                      sortAscending: sortFirstRow,
                    columns: <DataColumn>[
                      DataColumn(
                          label: Text("Name"),
                      numeric: false,
                      onSort: (i, b){
                            setState(() {
                              devicesList.sort((a,b) => a.name.compareTo(b.name));
                              sortFirstRow = !sortFirstRow;
                            });
                      }),
                      DataColumn(label: Text("MUD-Regeln")),
                      DataColumn(label: Text("Bearbeiten")),
                      DataColumn(label: Text("Löschen")),
                    ],
                    rows: devicesList
                        .map((device) => DataRow(cells: [
                              DataCell(Text(device.name)),
                              DataCell(Text(device.mudLaws)),
                              DataCell(IconButton(
                                icon: Icon(Icons.settings),
                                onPressed: () {},
                              )),
                              DataCell(IconButton(
                                icon: Icon(Icons.delete_forever),
                                onPressed: () {
                                  setState(() {
                                    deleteItem(device.name, device.mudLaws);
                                  });
                                },
                              )),
                            ]))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  /*void _generateTableRows() {
    for (int i = 0; i < 100; ++i) {
      int j = i;
      list.add(DataRow(key: Key(i.toString()), cells: <DataCell>[
        DataCell(Text(i.toString())),
        DataCell(Container(
            alignment: Alignment(0.0, 0.0), child: Text((i*i).toString()))),
        DataCell(Container(
            alignment: Alignment(0.0, 0.0),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ))),
        DataCell(Container(
            alignment: Alignment(0.0, 0.0),
            child: IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                DataRow test = list.elementAt(i);
                setState(() {
                  //String test = text.data;
                  list.remove(test.key);
                  for (int i = 0; i < list.length; i++){
                    list
                  }
                  print(test.toString());
                });
              },
            ))),
      ]));
    }


  }

   */

  var devicesList = <DeviceOverviewItem>[
    DeviceOverviewItem("Gerät3", "MUD Profil 3"),
    DeviceOverviewItem("Gerät4", "MUD Profil 4"),
    DeviceOverviewItem("Gerät5", "MUD Profil 5"),
    DeviceOverviewItem("Gerät6", "MUD Profil 6"),
    DeviceOverviewItem("Gerät7", "MUD Profil 7"),
    DeviceOverviewItem("Gerät2", "MUD Profil 2"),
    DeviceOverviewItem("Gerät8", "MUD Profil 8"),
    DeviceOverviewItem("Gerät9", "MUD Profil 9"),
    DeviceOverviewItem("Gerät1", "MUD Profil 1"),
  ];

  void deleteItem(String name, String mudLaws) {
    DeviceOverviewItem item = DeviceOverviewItem(name, mudLaws);
    for(int i = 0; i < devicesList.length; i++){
      if(devicesList.elementAt(i).name == item.name && devicesList.elementAt(i).mudLaws == item.mudLaws){
        setState(() {
          devicesList.removeAt(i);
        });
      }
    }
  }
}

class DeviceOverviewItem {
  String name;
  String mudLaws;

  DeviceOverviewItem(this.name, this.mudLaws);
}
