import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/aclElement.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:http/http.dart' as http;

// This class is a page to see the details of the choosen device
// You also can configure the (MUD)-Device-Profile or reset

class DeviceDetails extends StatefulWidget {
  const DeviceDetails({
    Key key,
    @required this.ipAddress,
  }) : super(key: key);
  final String ipAddress;

  _DeviceDetailsState createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  /// Simple list to safe the ACL from controller
  List<DataRow> list = [];
  bool sortFirstRow = false;
  bool sortFirstRow1 = false;
  bool editColumn = false;
  bool resetButton = false;

  /// A string that safes the selected clipart from the clipart-list
  String selectedClipArt = allClipArts[0];

  /// url extension
  String _updateMUDExtension = "mud/";

  Future<Device> deviceFuture;
  Device device;

  @override
  void initState() {
    super.initState();
    deviceFuture = fetchDevice();
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
      body: FutureBuilder(
        future: deviceFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            device = snapshot.data;
            return
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        SelectableText(
                          device.hostname,
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Visibility(
                          //The error message shows, if networkError is true
                          visible: adminAccess,
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    Size(120, 50)),
                              ),
                              onPressed: () {
                                _resetDialog();
                              },
                              child: Text(
                                "reset".tr().toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
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
                                      semanticsLabel: 'phone',
                                      height: 200,
                                      width: 200),
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Visibility(
                          //The error message shows, if networkError is true
                          visible: adminAccess,
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    Size(120, 50)),
                              ),
                              child: Text(
                                "Clipart ändern",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                _chooseClipartDialog(context);
                              },
                            ),
                          ),
                        ),

                        // Here are some text fields and boxes to display all pertinent information about the device
                        SizedBox(
                          height: 20,
                        ),
                        // Column(children: mobileDevice
                        //     ? _mobileView()
                        //     : _desktopView()),
                        Column(
                          children:
                            _mobileView()
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        // Table row to display and edit the different DNS-Requests
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SelectableText(
                                    'allowedDNSRequests'.tr().toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ]),
                            Visibility(
                              visible: adminAccess && !editColumn,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    minimumSize:
                                    MaterialStateProperty.all(Size(120, 50)),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      editColumn = !editColumn;
                                    });
                                  },
                                  child: Text(
                                    "edit".tr().toString(),
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ),
                            Visibility(
                              visible: editColumn,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    minimumSize:
                                    MaterialStateProperty.all(Size(120, 50)),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      editColumn = !editColumn;
                                    });
                                    _transmitData();
                                  },
                                  child: Text(
                                    "save".tr().toString(),
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ),
                            _expertModeText(context),
                          ],
                        ),
                        // This table displays the HTTP-addresses which are allowed
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            _tableDNSNames(),
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
              );
          }
          else if (snapshot.hasError) {
            return Container();
          }
          else {
            return Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },),
    );
  }

  Future _chooseClipartDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          // Here are displayed all cliparts to put devices in different classes
          // At the end there ist a pop-up dialog to save or dismiss the changes
          return StatefulBuilder(builder: (context, setState) {
            return Center(
              child: Theme(
                data: ThemeData(
                  brightness: darkMode ? Brightness.dark : Brightness.light,
                  primaryColor: primaryColor,
                  accentColor: primaryColor,
                  hintColor: Colors.grey,
                ),
                child: AlertDialog(
                  scrollable: true,
                  contentPadding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  content: Container(
                    width: 300,
                    height: 490,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              var clipArt = allClipArts[index];
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Buttons to accept or dismiss the changes like described above
                            TextButton(
                              child: Text(
                                "Abbrechen",
                                style: TextStyle(
                                  color: buttonColor,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(); // dismiss dialog
                              },
                            ),
                            TextButton(
                              child: Text(
                                "Übernehmen",
                                style: TextStyle(
                                  color: buttonColor,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(); // dismiss dialog
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  Expanded _tableDNSNames() {
    return Expanded(
      flex: 16,
      child: DataTable(
        onSelectAll: (b) {},
        sortColumnIndex: 0,
        sortAscending: sortFirstRow,
        columns: <DataColumn>[
          DataColumn(
            label: SelectableText("address".tr().toString()),
            numeric: false,
          ),
          DataColumn(
              label: Visibility(
                  visible: editColumn,
                  child: SelectableText("edit".tr().toString())))
        ],
        rows: device.mud_data.acl_override == null
            ? device.mud_data.acllist
            .map((accessControlEntry) =>
            DataRow(cells: [
              DataCell(Text(accessControlEntry.ace[0].matches.dnsname)),
              DataCell(
                Visibility(
                  visible: editColumn,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteDNSName(accessControlEntry);
                    },
                  ),
                ),
              )
            ]))
            .toList()
            : device.mud_data.acl_override
            .map((accessControlEntry) =>
            DataRow(cells: [
              DataCell(Text(accessControlEntry.ace[0].matches.dnsname)),
              DataCell(
                Visibility(
                  visible: editColumn,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteDNSName(accessControlEntry);
                    },
                  ),
                ),
              )
            ]))
            .toList(),
      ),
    );
  }

  void _deleteDNSName(ACLElement accessControlEntry) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            title: SelectableText("attention".tr().toString()),
            content: Container(
              width: 300,
              height: 175,
              child: Column(
                children: [
                  SelectableText("deleteDNSNameDisclaimer".tr().toString()),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Buttons to accept or dismiss the changes like described above
                      TextButton(
                        child: Text(
                          "cancel".tr().toString(),
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // dismiss dialog
                        },
                      ),
                      TextButton(
                        child: Text(
                          "delete".tr().toString(),
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (device.mud_data.acl_override == null) {
                              device.mud_data.acl_override =
                                  List.from(device.mud_data.acllist);
                            }
                            device.mud_data.acl_override
                                .remove(accessControlEntry);
                          });
                          Navigator.of(context).pop(); // dismiss dialog
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Visibility _expertModeText(BuildContext context) {
    return Visibility(
      visible: !expertMode,
      child:
      mobileDevice //if mobile device, then icon button with dialog, else icon with hover effect
          ? IconButton(
        icon: Icon(Icons.help_center),
        iconSize: 30,
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("explanation".tr().toString()),
                  content:
                  Text("explanationDNSNames".tr().toString()),
                  actions: [
                    TextButton(
                      child: Text("Ok!"),
                      onPressed: () {
                        Navigator.of(context).pop(); // dismiss dialog
                      },
                    )
                  ],
                );
              });
        },
      )
          : MouseRegion(
        //MouseRegion for the hover element
        onEnter: _enterInRegion,
        onExit: _exitInRegion,
        child: Icon(Icons.help_center),
      ),
    );
  }

  // This method launchs the MUDURL to the device, these URLs are the profils for the devices that are added to the app
  // if it not possible it will be thrown an error
  _launchMUDURL() async {
    if (await canLaunch(device.mud_url)) {
      await launch(device.mud_url);
    } else {
      throw 'Could not launch test';
    }
  }

  // This method launch the data to the profils, if it is not possible there will be thrown an error
  _launchDocumentation() async {
    if (await canLaunch(device.mud_data.documentation)) {
      await launch(device.mud_data.documentation);
    } else {
      throw 'Could not launch test';
    }
  }

  // This mehtod sends the MUD-Profil-Data to the controller
  Future _transmitData() async {
    Map<String, dynamic> data = {
      "acl_override": device.mud_data.acl_override
    };
    await http.put(url + _updateMUDExtension + device.mud_url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        },
        body: jsonEncode(data));
  }

  ///True if mouse is in the MouseRegion widget, else false
  bool inRegion = false;

  //Creating the overlay element just an example for expert mode
  OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) =>
          Center(
            child: Container(
              width: 400,
              height: 200,
              padding: EdgeInsets.all(20),
              alignment: Alignment(0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: darkMode
                    ? Colors.black.withOpacity(0.9)
                    : Colors.grey.withOpacity(0.9),
              ),
              child: Column(
                children: [
                  SelectableText(
                    "explanation".tr().toString(),
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 35,
                        color: darkMode ? Colors.white : Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SelectableText(
                    "explanationDNSNames".tr().toString(),
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20,
                        color: darkMode ? Colors.white : Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
            ),
          ));

  //Function that shows the overlay element
  showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    overlayState.insert(overlayEntry);
  }

  //Function for closing the overlay element
  closeOverlay() {
    overlayEntry.remove();
  }

  //Function called from MouseRegion widget below, opens the overlay on mouse enter
  void _enterInRegion(PointerEvent details) {
    setState(() {
      inRegion = true;
    });
    showOverlay(context);
  }

  //Function called from MouseRegion widget below, closes the overlay on mouse exit
  void _exitInRegion(PointerEvent details) {
    setState(() {
      inRegion = false;
    });
    closeOverlay();
  }


  List<Widget> _desktopView() {
    var column1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              "ipaddress".tr().toString() + ": ",
              style: TextStyle(fontSize: 20),
            ),
            SelectableText(
              device.ip_addr,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              "MUD URL: ",
              style: TextStyle(fontSize: 20),
            ),
            SelectableText(
              device.mud_url,
              style: TextStyle(fontSize: 18),
              onTap: () {
                _launchMUDURL();
              },
            ),
          ],
        )
      ],
    );

    var column2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              "lastinteraction".tr().toString() + ": ",
              style: TextStyle(fontSize: 20),
            ),
            SelectableText(
              device.last_interaction,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Visibility(
          visible: device.mud_data.documentation != null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                'documentation'.tr().toString() + ": ",
                style: TextStyle(fontSize: 20),
              ),
              SelectableText(
                device.mud_data.documentation,
                style: TextStyle(fontSize: 18),
                onTap: () {
                  _launchDocumentation();
                },
              ),
            ],
          )
        )
      ],
    );

    var row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        column1,
        SizedBox(
          width: 200,
        ),
        column2
      ],
    );

    List<Widget> list = [
      SizedBox(
        height: 40,
      ),
      row,
      SizedBox(
        height: 30,
      )
    ];
    return list;
  }

  List<Widget> _mobileView() {
    var selectableText1 = SelectableText(
      "ipaddress".tr().toString(),
      style: TextStyle(fontSize: 20),
    );
    var selectableText2 = SelectableText(
      device.ip_addr,
      style: TextStyle(fontSize: 18),
    );
    var sizedBox1 = SizedBox(
      height: 20,
    );
    var selectableText3 = SelectableText(
      "lastinteraction".tr().toString(),
      style: TextStyle(fontSize: 20),
    );
    var selectableText4 = SelectableText(
      device.last_interaction,
      style: TextStyle(fontSize: 18),
    );
    var sizedBox2 = SizedBox(
      height: 20,
    );
    var selectableText5 = SelectableText(
      "MUD URL: ",
      style: TextStyle(fontSize: 20),
    );
    var selectableText6 = SelectableText(
      device.mud_url,
      style: TextStyle(fontSize: 18),
      onTap: () {
        _launchMUDURL();
      },
    );
    var sizedBox3 = SizedBox(
      height: 20,
    );

    List<Widget> list = [
      selectableText1,
      selectableText2,
      sizedBox1,
      selectableText3,
      selectableText4,
      sizedBox2,
      selectableText5,
      selectableText6,
      sizedBox3,
    ];

    if (device.mud_data.documentation != null) {
      var selectableText7 = SelectableText(
        'documentation'.tr().toString(),
        style: TextStyle(fontSize: 20),
      );
      var selectableText8 = SelectableText(
        device.mud_data.documentation,
        style: TextStyle(fontSize: 18),
        onTap: () {
          _launchDocumentation();
        },
      );
      list.add(selectableText7);
      list.add(selectableText8);
    }

    return list;
  }

  // This dialog opens up if the reset-button is clicked
  void _resetDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            title: SelectableText("attention".tr().toString()),
            content: Container(
              width: 300,
              height: 175,
              child: Column(
                children: [
                  SelectableText("resetDisclaimer".tr().toString()),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Buttons to accept or dismiss the changes like described above
                      TextButton(
                        child: Text(
                          "cancel".tr().toString(),
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // dismiss dialog
                        },
                      ),
                      TextButton(
                        child: Text(
                          "reset".tr().toString(),
                          style: TextStyle(
                            color: buttonColor,
                          ),
                        ),
                        onPressed: () async {
                          Map<String, dynamic> data = {"acl_override": null};
                          await http.put(
                              url + _updateMUDExtension + device.mud_url,
                              headers: {
                                "Content-Type": "application/json",
                                "Authorization": "Bearer $jwtToken"
                              },
                              body: jsonEncode(data));
                          Navigator.of(context).pop(); // dismiss dialog
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  // This function gets the device-details from the controller
  Future<Device> fetchDevice() async {
    String deviceExtension = "devices/";

    var _response = await http.get(url + deviceExtension + widget.ipAddress,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        });
    if(_response.statusCode == 200){
      Device deviceFormController = Device.fromJson(jsonDecode(_response.body));
      return deviceFormController;
    }else{
      return null;
    }

  }
}
