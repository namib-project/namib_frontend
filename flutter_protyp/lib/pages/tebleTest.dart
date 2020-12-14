import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  @override
  void initState() {
    _generateTableRows();
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
              child: DataTable(
                columns: <DataColumn>[
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("MUD-Regeln")),
                  DataColumn(label: Text("Bearbeiten")),
                  DataColumn(label: Text("Löschen")),
                ],
                rows: list,
              ),
            ),
          ),
        ));
  }

  void _generateTableRows() {
    for (int i = 0; i < 100; ++i) {
      list.add(DataRow(cells: <DataCell>[
        DataCell(Text(i.toString())),
        DataCell(Container(
            alignment: Alignment(0.0, 0.0), child: Text((i * i).toString()))),
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
                Text text = list.elementAt(i).cells.elementAt(0).child;
                setState(() {
                  String test = text.data;
                  list.removeAt(int.parse(test));
                  print(test.toString());
                });
              },
            ))),
      ]));
    }
  }
}
