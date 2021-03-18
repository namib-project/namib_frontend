import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/newDevice.dart';
import 'package:flutter_protyp/widgets/constant.dart';

class NewDevicesTable extends StatefulWidget {
  const NewDevicesTable({
    Key key,
    @required this.devices,
  }) : super(key: key);

  /// List which stores all given devices
  final List<Device> devices;

  _NewDevicesTableState createState() => _NewDevicesTableState();
}

//Class for user registration, will only be used at the first usage
class _NewDevicesTableState extends State<NewDevicesTable> {
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
                    'Unverwaltete Geräte'.tr().toString(),
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: SelectableText(
                    "Wählen Sie ein Gerät zum Hinzufügen",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20,
                    ),
                  ),
                ),

                // This row table is to display the given devices and their MUD-Profiles
                // you can edit the Profiles at the edit button
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                        flex: 16,
                        child: widget.devices != null
                            ? _tableForData(context)
                            : _tableNoEntries()),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              "Abbrechen",
                              style: TextStyle(
                                color: buttonColor,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () => {
                              Navigator.pushReplacementNamed(
                                  context, "/deviceOverview")
                            },
                          ),
                          Visibility(
                            visible: adminAccess,
                            child: FlatButton(
                              child: Text(
                                "Hinzufügen",
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewDevice(),
                                  ),
                                )
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataTable _tableNoEntries() {
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: SelectableText("device".tr().toString()),
        ),
      ],
      rows: [
        DataRow(cells: [
          DataCell(SelectableText("noEntries".tr().toString())),
        ])
      ],
    );
  }

  DataTable _tableForData(BuildContext context) {
    return DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 0,
      sortAscending: sortFirstRow,
      columns: <DataColumn>[
        DataColumn(
          label: SelectableText("device".tr().toString()),
          numeric: false,
        ),
        DataColumn(
          label: SelectableText(
            "select".tr().toString(),
          ),
        ),
      ],
      rows: widget.devices
          .map((device) => DataRow(cells: [
                DataCell(SelectableText(device.mud_data.systeminfo)),
                DataCell(
                  Checkbox(
                      activeColor: buttonColor,
                      value: false,
                      onChanged: (bool value) {}),
                ),
              ]))
          .toList(),
    );
  }
}
