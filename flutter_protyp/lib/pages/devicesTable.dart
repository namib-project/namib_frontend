import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/deviceDetails.dart';
import 'package:flutter_protyp/widgets/constant.dart';

class DevicesTable extends StatefulWidget {
  const DevicesTable({
    Key key,
    @required this.devices,
  }) : super(key: key);

  /// List which stores all given devices
  final List<Device> devices;

  _DevicesTableState createState() => _DevicesTableState();
}

//Class for user registration, will only be used at the first usage
class _DevicesTableState extends State<DevicesTable> {
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

                // This row table is to display the given devices and their MUD-Profiles
                // you can edit the Profiles at the edit button
                Row(children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 16,
                      child: widget.devices != null
                          ? _tableForData(context)
                          : _tableNoEntries()),
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

  DataTable _tableNoEntries() {
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: SelectableText("device".tr().toString()),
        ),
        DataColumn(label: SelectableText("MUD")),
        DataColumn(label: SelectableText("edit".tr().toString()))
      ],
      rows: [
        DataRow(cells: [
          DataCell(SelectableText("noEntries".tr().toString())),
          DataCell(SelectableText("noEntries".tr().toString())),
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
        DataColumn(label: SelectableText("MUD")),
        DataColumn(label: SelectableText("edit".tr().toString()))
      ],
      rows: widget.devices
          .map((device) => DataRow(cells: [
                DataCell(SelectableText(device.mud_data.systeminfo)),
                DataCell(SelectableText(device.mud_url)),
                DataCell(IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    //Navigator.pushNamed(
                    //    context, "/deviceDetails");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeviceDetails(
                          device: device,
                        ),
                      ),
                    );
                  },
                )),
              ]))
          .toList(),
    );
  }
}
