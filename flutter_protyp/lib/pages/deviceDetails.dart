import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:websafe_svg/websafe_svg.dart';

class DeviceDetails extends StatefulWidget {
  const DeviceDetails({
    Key key,
    @required this.device,
  }) : super(key: key);
  final Device device;

  _DeviceDetailsState createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  /// Simple list to safe the ACL fromo controller
  List<DataRow> list = [];
  bool sortFirstRow = false;
  bool sortFirstRow1 = false;
  bool editColumn = false;

  /// A string that safes the selected clipart from the clipart-list
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
                          child: WebsafeSvg.asset(allClipArts[0],
                              semanticsLabel: 'phone', height: 200, width: 200),
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
                          // Here are displayed all cliparts to put devieces in different classes
                          // At the end there ist a pop-up dialog to save or dismiss the changes
                          return StatefulBuilder(builder: (context, setState) {
                            return Theme(
                              data: ThemeData(
                                primaryColor: primaryColor,
                                accentColor: primaryColor,
                                hintColor: Colors.grey,
                              ),
                              child: Center(
                                child: SingleChildScrollView(
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    content: Container(
                                      width: 300,
                                      height: 490,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                height: 200,
                                                width: 200,
                                                child: WebsafeSvg.asset(
                                                  selectedClipArt,
                                                  color: Colors.blue,
                                                  height: 200,
                                                  width: 200,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20,
                                          ),
                                          Container(
                                            height: 200,
                                            child: GridView.builder(
                                              itemCount: allClipArts.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 4,
                                                mainAxisSpacing: 4,
                                              ),
                                              itemBuilder: (context, index) {
                                                var clipArt =
                                                    allClipArts[index];
                                                return GestureDetector(
                                                  child: Container(
                                                    child: WebsafeSvg.asset(
                                                      clipArt,
                                                      semanticsLabel: 'phone',
                                                      height: 80,
                                                      width: 80,
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
                                          SizedBox(
                                            height: 22,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Buttons to accept or dismiss the changes like discribed above
                                              FlatButton(
                                                child: Text(
                                                  "Abbrechen",
                                                  style: TextStyle(
                                                    color: buttonColor,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // dismiss dialog
                                                },
                                              ),
                                              FlatButton(
                                                child: Text(
                                                  "Übernehmen",
                                                  style: TextStyle(
                                                    color: buttonColor,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // dismiss dialog
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        });
                  },
                ),

                // Here are some textfields and boxes to display allpertinent information about the device
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
                // Table row to display and edit the diffrent DNS-Requests
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
                // This table displays the HTTP-Adresses which are allowed
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
                        rows: widget.device.mud_data.acllist
                            .map((accessControlEntry) => DataRow(cells: [
                                  DataCell(
                                      Text(accessControlEntry.ace[0].matches.dnsname)),
                                  DataCell(
                                    Visibility(
                                      visible: editColumn,
                                      child: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            widget
                                                .device.mud_data.acllist
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

  // This method launchs the MUDURL to the device, these URLs are the profils for the devices that are added to the app
  // if it not possible it will be thrown an error
  _launchMUDURL() async {
    if (await canLaunch(widget.device.mud_url)) {
      await launch(widget.device.mud_url);
    } else {
      throw 'Could not launch test';
    }
  }

  // This method launch the datas to the profils, if it is not possible there will be thrown an error
  _launchDocumentation() async {
    if (await canLaunch(widget.device.mud_data.documentation)) {
      await launch(widget.device.mud_data.documentation);
    } else {
      throw 'Could not launch test';
    }
  }

  Future _transmitData() async {}
}
