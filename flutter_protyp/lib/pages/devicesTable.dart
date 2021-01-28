import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device.dart';
import 'package:flutter_protyp/pages/deviceDetails.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:http/http.dart' as http;

class TableTest extends StatefulWidget {
  _TableTestState createState() => _TableTestState();
}

//Class for user registration, will only be used at the first usage
class _TableTestState extends State<TableTest> {
  bool sortFirstRow = false;

  Future<List<Device>> devices;

  @override
  void initState() {
    super.initState();
    devices = getDevices();
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
                  FutureBuilder<List<Device>>(
                    future: devices,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                            flex: 16,
                            child: SingleChildScrollView(
                              child: DataTable(
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
                                          devicesForPresentation.sort((a, b) =>
                                              a.systeminfo
                                                  .compareTo(b.systeminfo));
                                          sortFirstRow = !sortFirstRow;
                                        });
                                      }),
                                  DataColumn(label: SelectableText("MUD")),
                                  DataColumn(
                                      label: SelectableText(
                                          "edit".tr().toString()))
                                ],
                                rows: snapshot.data
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
                              ),
                            ));
                      } else if (snapshot.hasError) {
                        return Expanded(
                          flex: 16,
                            child: SingleChildScrollView(
                          child: DataTable(
                            columns: <DataColumn>[
                              DataColumn(
                                label: SelectableText(
                                  "device".tr().toString(),
                                ),
                              ),
                              DataColumn(
                                label: SelectableText("MUD"),
                              ),
                              DataColumn(
                                label: SelectableText(
                                  "edit".tr().toString(),
                                ),
                              )
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(
                                    SelectableText(
                                      "noEntries".tr().toString(),
                                    ),
                                  ),
                                  DataCell(
                                    SelectableText(
                                      "noEntries".tr().toString(),
                                    ),
                                  ),
                                  DataCell(
                                    SelectableText(
                                      "noEntries".tr().toString(),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ));
                      }
                      // By default, show a loading spinner.
                      else {
                        return SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
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
    ));
  }

  // Function getting the list of devices in network from controller
  Future<List<Device>> getDevices() async {
    String urlDevices = 'http://172.26.144.1:8000/devices/';
    var responseDevices;
    //responseDevices = await http.get(urlDevices);
    String test =
        '[{"hostname": "string","id": 0,"ip_addr": "string","last_interaction": "string","mac_addr": "string","mud_data": {"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "ntp.org"},"name": "string"},{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "weather.com"},"name": "string"},{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice", "dnsname": "xyz.media"},"name": "string"},{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "storage.de"},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-01-23T10:35:17.609Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"},"mud_url": "string","vendor_class": "string"}, {"hostname": "string","id": 0,"ip_addr": "string","last_interaction": "string","mac_addr": "string","mud_data": {"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","direction_initiated": "FromDevice","dnsname": "string"},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-01-17T21:05:00.692Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"},"mud_url": "string","vendor_class": "string"}]';
    var jsonDevices = jsonDecode(test) as List;
    List<Device> devicesTest =
        jsonDevices.map((tagJson) => Device.fromJson(tagJson)).toList();
    return devicesTest;
    //if (responseDevices.statusCode == 200) {
    //  return devicesTest;
    //} else {
    //  throw Exception("Failed to get Data");
    //}
    //TODO bei release auf http request umstellen
  }
}
