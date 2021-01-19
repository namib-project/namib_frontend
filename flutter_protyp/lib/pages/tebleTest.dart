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

  @override
  void initState() {
    super.initState();
  }

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
              Row(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 16,
                    child: widget.devices != null ? DataTable(
                      onSelectAll: (b) {},
                      sortColumnIndex: 0,
                      sortAscending: sortFirstRow,
                      columns: <DataColumn>[
                        DataColumn(
                            label: SelectableText("device".tr().toString()),
                            numeric: false,
                            onSort: (i, b) {
                              setState(() {
                                devicesForPresentation.sort((a, b) =>
                                    a.systeminfo.compareTo(b.systeminfo));
                                sortFirstRow = !sortFirstRow;
                              });
                            }),
                        DataColumn(label: SelectableText("MUD")),
                        DataColumn(
                            label: SelectableText("edit".tr().toString()))
                      ],
                      rows: widget.devices
                          .map((device) => DataRow(cells: [
                                DataCell(Text(device.mud_data.systeminfo)),
                                DataCell(Text(device.mud_url)),
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
                    ): CircularProgressIndicator(
                        strokeWidth: 1.0
                    ),
                  ),
                  Expanded(flex: 1, child: Container())
                ],
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

//  void deleteItem(String name, String mudLaws) {
//    DeviceOverviewItem item = DeviceOverviewItem(name, mudLaws);
//    for (int i = 0; i < devicesList.length; i++) {
//      if (devicesList.elementAt(i).name == item.name &&
//          devicesList.elementAt(i).mudLaws == item.mudLaws) {
//        setState(() {
//          devicesList.removeAt(i);
//        });
//      }
//    }
//  }
//}

//class DeviceOverviewItem {
//  String name;
//  String mudLaws;
//
//  DeviceOverviewItem(this.name, this.mudLaws);

}
