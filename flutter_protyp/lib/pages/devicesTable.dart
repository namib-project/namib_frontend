import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device.dart';
import 'package:flutter_protyp/pages/deviceDetails.dart';
import 'package:flutter_protyp/widgets/constant.dart';

class TableTest extends StatefulWidget {
  const TableTest({
    Key key,
    @required this.devices,
  }) : super(key: key);
  final List<Device> devices;

  _TableTestState createState() => _TableTestState();
}

//Class for user registration, will only be used at the first usage
class _TableTestState extends State<TableTest> {
  bool sortFirstRow = false;

  Widget build(BuildContext context) {
    return new Scaffold(
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
                Row(children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 16,
                      child: widget.devices != null
                          ? DataTable(
                              onSelectAll: (b) {},
                              sortColumnIndex: 0,
                              sortAscending: sortFirstRow,
                              columns: <DataColumn>[
                                DataColumn(
                                    label: SelectableText(
                                        "device".tr().toString()),
                                    numeric: false,
                                    onSort: (i, b) {
                                      setState(() {
                                        devicesForPresentation.sort((a, b) => a
                                            .systeminfo
                                            .compareTo(b.systeminfo));
                                        sortFirstRow = !sortFirstRow;
                                      });
                                    }),
                                DataColumn(label: SelectableText("MUD")),
                                DataColumn(
                                    label:
                                        SelectableText("edit".tr().toString()))
                              ],
                              rows: widget.devices
                                  .map((device) => DataRow(cells: [
                                        DataCell(SelectableText(
                                            device.mud_data.systeminfo)),
                                        DataCell(
                                            SelectableText(device.mud_url)),
                                        DataCell(IconButton(
                                          icon: Icon(Icons.settings),
                                          onPressed: () {
                                            //Navigator.pushNamed(
                                            //    context, "/deviceDetails");
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DeviceDetails(
                                                  device: device,
                                                ),
                                              ),
                                            );
                                          },
                                        )),
                                      ]))
                                  .toList(),
                            )
                          : DataTable(
                              columns: <DataColumn>[
                                DataColumn(
                                  label:
                                      SelectableText("device".tr().toString()),
                                ),
                                DataColumn(label: SelectableText("MUD")),
                                DataColumn(
                                    label:
                                        SelectableText("edit".tr().toString()))
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(SelectableText(
                                      "noEntries".tr().toString())),
                                  DataCell(SelectableText(
                                      "noEntries".tr().toString())),
                                  DataCell(SelectableText(
                                      "noEntries".tr().toString())),
                                ])
                              ],
                            )),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
