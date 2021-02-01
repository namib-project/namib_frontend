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
import 'package:flutter_svg/flutter_svg.dart';

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

  String selectedClipArt = allClipArts[0];

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
                      child: GestureDetector(
                        child: Container(
                          height: 200,
                          width: 200,
                          child: SvgPicture.asset(
                            allClipArts[0],
                            semanticsLabel: 'phone',
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text("Clipart ändern"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              content: Container(
                                width: 300,
                                height: 600,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 300,
                                          width: 250,
                                          child: SvgPicture.asset(
                                            selectedClipArt,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 250,
                                      child: GridView.builder(
                                        itemCount: allClipArts.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 4,
                                          mainAxisSpacing: 4,
                                        ),
                                        itemBuilder: (context, index) {
                                          var clipArt = allClipArts[index];
                                          return GestureDetector(
                                            child: Container(
                                              child: SvgPicture.asset(
                                                clipArt,
                                                semanticsLabel: 'phone',
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                selectedClipArt = clipArt;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                FlatButton(
                                  child: Text("Ok!"),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // dismiss dialog
                                  },
                                )
                              ],
                            );
                          });
                        });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SelectableText(
                  "ipaddress".tr().toString(),
                  style: TextStyle(fontSize: 20),
                ),
                SelectableText(
                  widget.device.ip_addr,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                SelectableText(
                  "lastinteraction".tr().toString(),
                  style: TextStyle(fontSize: 20),
                ),
                SelectableText(
                  widget.device.last_interaction,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
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
                  onTap: () {
                    _launchDocumentation();
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                  ],
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

  Future _transmitData() async {}
}
