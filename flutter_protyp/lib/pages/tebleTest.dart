import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/dataForPresentation/device.dart';
import 'package:flutter_protyp/dataForPresentation/service.dart';

class TableTest extends StatefulWidget {
  @override
  _TableTestState createState() => _TableTestState();
}

//Class for user registration, will only be used at the first usage
class _TableTestState extends State<TableTest> {
  List<DataRow> list = [];
  bool sortFirstRow = false;

  List<DeviceForPresentation> devices;
  List<ServiceForPresentaion> services;

  @override
  void initState() {
    super.initState();
    test();
  }

  DeviceForPresentation testDevice1;
  DeviceForPresentation testDevice2;
  DeviceForPresentation testDevice3;
  DeviceForPresentation testDevice4;

  void test() {
    testDevice1 = DeviceForPresentation(
        "Light Bulb Livingroom",
        "Foo MUD",
        "0.1",
        "192.168.1.2",
        "https://upload.wikimedia.org/wikipedia/commons/d/dc/In_front_of_Kiyosato_Station03n4592.jpg",
        "https://lighting.example.com/lightbulb2000",
        "NoOneHasSignedThis",
        "https://lighting.example.com/documentation",
        services,
        allowedDNSRequests);

    testDevice2 = DeviceForPresentation(
        "Light Bulb Bedroom",
        "Foo MUD",
        "0.1",
        "192.168.1.2",
        "https://upload.wikimedia.org/wikipedia/commons/d/dc/In_front_of_Kiyosato_Station03n4592.jpg",
        "https://lighting.example.com/lightbulb2000",
        "NoOneHasSignedThis",
        "https://lighting.example.com/documentation",
        services,
        allowedDNSRequests);

    testDevice3 = DeviceForPresentation(
        "Light Bulb Kidsroom",
        "Foo MUD",
        "0.1",
        "192.168.1.2",
        "https://upload.wikimedia.org/wikipedia/commons/d/dc/In_front_of_Kiyosato_Station03n4592.jpg",
        "https://lighting.example.com/lightbulb2000",
        "NoOneHasSignedThis",
        "https://lighting.example.com/documentation",
        services,
        allowedDNSRequests);

    testDevice4 = DeviceForPresentation(
        "Light Bulb Hallway",
        "Foo MUD",
        "0.1",
        "192.168.1.2",
        "https://upload.wikimedia.org/wikipedia/commons/d/dc/In_front_of_Kiyosato_Station03n4592.jpg",
        "https://lighting.example.com/lightbulb2000",
        "NoOneHasSignedThis",
        "https://lighting.example.com/documentation",
        services,
        allowedDNSRequests);
    devices = <DeviceForPresentation>[
      testDevice1,
      testDevice2,
      testDevice3,
      testDevice4
    ];
    services = [service1, service2, service3];
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
                        child: DataTable(
                          onSelectAll: (b) {},
                          sortColumnIndex: 0,
                          sortAscending: sortFirstRow,
                          columns: <DataColumn>[
                            DataColumn(
                                label: SelectableText("device".tr().toString()),
                                numeric: false,
                                onSort: (i, b) {
                                  setState(() {
                                    devices.sort(
                                            (a, b) =>
                                            a.systeminfo.compareTo(
                                                b.systeminfo));
                                    sortFirstRow = !sortFirstRow;
                                  });
                                }),
                            DataColumn(label: SelectableText("MUD-Name")),
                            DataColumn(
                                label: SelectableText("edit".tr().toString()))
                          ],
                          rows: devices
                              .map((device) =>
                              DataRow(cells: [
                                DataCell(Text(device.systeminfo)),
                                DataCell(Text(device.name)),
                                DataCell(IconButton(
                                  icon: Icon(Icons.settings),
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, "/deviceDetails");
                                  },
                                )),
                              ]))
                              .toList(),
                        ),
                      ),
                      Expanded(flex:1,child: Container())
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

  List<String> allowedDNSRequests = [
    "www.example.net",
    "0.north-america.pool.ntp.org",
    "media.whooshkaa.com"
  ];

  String json1 = '{"name":"Foo Service","product":"null","method":"null"}';
  String json2 = '{"name":"DNS Service","product":"null","method":"null"}';
  String json3 = '{"name":"NTP Service","product":"null","method":"null"}';

  ServiceForPresentaion service1 =
  ServiceForPresentaion("Foo Service", "null", "null");
  ServiceForPresentaion service2 =
  ServiceForPresentaion("DNS Service", "null", "null");
  ServiceForPresentaion service3 =
  ServiceForPresentaion("NTP Service", "null", "null");
}
