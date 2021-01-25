import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/pages/devicesTable.dart';
import 'package:flutter_protyp/dataForPresentation/device.dart';
import 'package:flutter_protyp/dataForPresentation/service.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceDetails extends StatefulWidget {
  const DeviceDetails({
    Key key,
    @required this.device,
  }) : super(key: key);
  final Device device;

  _DeviceDetailsState createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  List<DataRow> list = [];
  bool sortFirstRow = false;
  bool sortFirstRow1 = false;
  bool editColumn = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: SelectableText("Details"),
        actions: <Widget>[
          Padding(
            padding: mobileDevice
                ? EdgeInsets.fromLTRB(12, 5, 12, 12)
                : EdgeInsets.fromLTRB(0, 5, 12, 12),
            child: SettingsPopup(),
          ),
        ],
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
                SelectableText(
                  widget.device.mud_data.systeminfo,
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
                SelectableText(
                  "MUD URL: ",
                  style: TextStyle(fontSize: 20),
                ),
                SelectableText(
                  widget.device.mud_url,
                  style: TextStyle(fontSize: 18),
                  onTap: () {
                    _launchMUDURL();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SelectableText(
                  'documentation'.tr().toString(),
                  style: TextStyle(fontSize: 20),
                ),
                SelectableText(
                  widget.device.mud_data.documentation,
                  style: TextStyle(fontSize: 18),
                  onTap: (){
                    _launchDocumentation();
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                SelectableText(
                  'allowedDNSRequests'.tr().toString(),
                  style: TextStyle(fontSize: 22),
                ),
                Visibility(
                  visible: !editColumn,
                  child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          editColumn = !editColumn;
                        });
                      },
                      child: Text("edit".tr().toString())),
                ),
                Visibility(
                  visible: editColumn,
                  child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          editColumn = !editColumn;
                        });
                        _transmitData();
                      },
                      child: Text("save".tr().toString())),
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
                              label: SelectableText("address".tr().toString()),
                              numeric: false,
                              onSort: (i, b) {
                                setState(() {
                                  services
                                      .sort((a, b) => a.name.compareTo(b.name));
                                  sortFirstRow = !sortFirstRow;
                                });
                              }),
                          DataColumn(
                              label: Visibility(
                                  visible: editColumn,
                                  child:
                                      SelectableText("edit".tr().toString())))
                        ],
                        rows: widget.device.mud_data.acllist[0].ace
                            .map((accessControlEntry) => DataRow(cells: [
                                  DataCell(
                                      Text(accessControlEntry.matches.dnsname)),
                                  DataCell(
                                    Visibility(
                                      visible: editColumn,
                                      child: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            widget
                                                .device.mud_data.acllist[0].ace
                                                .remove(accessControlEntry);
                                          });
                                        },
                                      ),
                                    ),
                                  )
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchMUDURL() async {
    if (await canLaunch(widget.device.mud_url)) {
      await launch(widget.device.mud_url);
    } else {
      throw 'Could not launch test';
    }
  }

  _launchDocumentation() async {
    if (await canLaunch(widget.device.mud_data.documentation)) {
      await launch(widget.device.mud_data.documentation);
    } else {
      throw 'Could not launch test';
    }
  }

  Future _transmitData() async{

  }
}
