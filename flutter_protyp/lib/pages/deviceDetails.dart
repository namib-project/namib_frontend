import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/pages/tebleTest.dart';
import 'package:flutter_protyp/dataForPresentation/device.dart';
import 'package:flutter_protyp/dataForPresentation/service.dart';
import 'package:flutter_protyp/widgets/constant.dart';

class DeviceDetails extends StatefulWidget {
  @override
  _DeviceDetailsState createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  List<DataRow> list = [];
  bool sortFirstRow = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  testDevice1.systeminfo,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        testDevice1.image,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "MUD_Signatur: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  testDevice1.mud_signature,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "MUD_URL: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  testDevice1.mud_url,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Documentation: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  testDevice1.documentation,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Services: ",
                  style: TextStyle(fontSize: 22),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 16,
                      child: DataTable(
                        onSelectAll: (b) {},
                        sortColumnIndex: 0,
                        sortAscending: sortFirstRow,
                        columns: <DataColumn>[
                          DataColumn(
                              label: SelectableText("Service".tr().toString()),
                              numeric: false,
                              onSort: (i, b) {
                                setState(() {
                                  devices.sort((a, b) =>
                                      a.systeminfo.compareTo(b.systeminfo));
                                  sortFirstRow = !sortFirstRow;
                                });
                              }),
                          DataColumn(
                              label: SelectableText("edit".tr().toString()))
                        ],
                        rows: services
                            .map((service) => DataRow(cells: [
                                  DataCell(Text(service.name)),
                                  DataCell(IconButton(
                                    icon: Icon(Icons.settings),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, "/deviceDetails");
                                    },
                                  )),
                                ]))
                            .toList(),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Allowed DNS Requests: ",
                  style: TextStyle(fontSize: 22),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 16,
                      child: DataTable(
                        onSelectAll: (b) {},
                        sortColumnIndex: 0,
                        sortAscending: sortFirstRow,
                        columns: <DataColumn>[
                          DataColumn(
                              label: SelectableText(
                                  "DNS Requests".tr().toString()),
                              numeric: false,
                              onSort: (i, b) {
                                setState(() {
                                  devices.sort((a, b) =>
                                      a.systeminfo.compareTo(b.systeminfo));
                                  sortFirstRow = !sortFirstRow;
                                });
                              }),
                          DataColumn(
                              label: SelectableText("edit".tr().toString()))
                        ],
                        rows: allowedDNSRequests
                            .map((request) => DataRow(cells: [
                                  DataCell(Text(request)),
                                  DataCell(IconButton(
                                    icon: Icon(Icons.settings),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, "/deviceDetails");
                                    },
                                  )),
                                ]))
                            .toList(),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
