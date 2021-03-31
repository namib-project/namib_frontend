import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/aclElement.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/deviceDetailsTable.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

// This class is a page to see the details of the choosen device
// You also can configure the (MUD)-Device-Profile or reset

class DeviceDetails extends StatefulWidget {
  const DeviceDetails({
    Key key,
    @required this.id,
  }) : super(key: key);
  final int id;

  _DeviceDetailsState createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  /// Simple list to safe the ACL from controller
  List<DataRow> list = [];

  bool editColumn = false;
  bool resetButton = false;

  List<String> _aclListForDisplay = [];
  List<String> _aclListCopy = [];

  bool _sortAscending = true;
  Icon _arrowUp = Icon(
    FontAwesomeIcons.arrowUp,
    size: 17,
  );
  Icon _arrowDown = Icon(
    FontAwesomeIcons.arrowDown,
    size: 17,
  );

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
      body: FutureBuilder<Device>(
        future: deviceFuture,
        builder: (context, snapshot) {
          /// TODO: fix this shit
          if (snapshot.hasData) {

            return DeviceDetailsTable(device: snapshot.data);
          } else if (snapshot.hasError) {
            // If the process failed this message returns
            print(snapshot.error);
            return Container(
              width: 600,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SelectableText("wentWrongError".tr().toString()),
                    ElevatedButton(
                        child: Text("reload".tr().toString()),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, "/deviceOverview");
                        })
                  ]),
            );
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
    );
  }

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

  _listHeader() {
    return Container(
      height: 80,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          _sortAscending = !_sortAscending;
          _sortAclListForDisplay();
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: _sortAscending ? _arrowUp : _arrowDown,
                        ),
                        Text(
                          'address'.tr().toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: editColumn,
                  child: Text(
                    'edit'.tr().toString(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'search'.tr().toString(),
          suffixIcon: Icon(
            FontAwesomeIcons.search,
          ),
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _aclListForDisplay = _aclListCopy.where((aceElement) {
              var aceName = aceElement.toLowerCase();
              return aceName.contains(text);
            }).toList();
          });
          _sortAclListForDisplay();
        },
      ),
    );
  }

  ListView _listForAcl() {
    return ListView.builder(
      itemCount: _aclListForDisplay.length,
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {},
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _aclListForDisplay[index],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Visibility(
                      visible: editColumn,
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.edit,
                          size: 17,
                        ),
                        onPressed: () {
                          _deleteDNSName(_aclListForDisplay[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _generateDnsList() {
    _aclListCopy = [];
    if (device.mud_data.acl_override.isEmpty) {
      device.mud_data.acllist.forEach((aclElement) {
        aclElement.ace.forEach((aceElement) {
          if (aceElement.matches.dnsname != null) {
            _aclListCopy.add(aceElement.matches.dnsname);
          }
        });
      });
    } else {
      device.mud_data.acl_override.forEach((aclElement) {
        aclElement.ace.forEach((aceElement) {
          if (aceElement.matches.dnsname != null) {
            _aclListCopy.add(aceElement.matches.dnsname);
          }
        });
      });
    }
    (_aclListCopy);
  }

  _sortAclListForDisplay() {
    setState(() {
      if (_sortAscending) {
        _aclListForDisplay.sort((a, b) => a.compareTo(b));
      } else {
        _aclListForDisplay.sort((a, b) => b.compareTo(a));
      }
    });
  }

  void _deleteDNSName(String accessControlEntry) {
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
                            if (device.mud_data.acl_override == null ||
                                device.mud_data.acl_override == []) {
                              device.mud_data.acl_override =
                                  List.from(device.mud_data.acllist);
                            }
                            device.mud_data.acl_override.forEach((aclElement) {
                              aclElement.ace.forEach((aceElement) {
                                if (aceElement.matches.dnsname ==
                                    accessControlEntry) {
                                  device.mud_data.acl_override
                                      .remove(aceElement);

                                  _aclListForDisplay.remove(aceElement);
                                }
                              });
                            });
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

  // This method sends the MUD-Profile-Data to the controller
  Future _transmitData() async {
    Map<String, dynamic> data = {"acl_override": device.mud_data.acl_override};
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
      builder: (context) => Center(
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
              device.ipv4_addr == null ? device.ipv6_addr : device.ipv4_addr,
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
            ))
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
      device.ipv4_addr == null ? device.ipv6_addr : device.ipv4_addr,
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

  // This function gets the device-details from the controller
  Future<Device> fetchDevice() async {
    String deviceExtension = "devices/";

    var _response = await http.get(url + deviceExtension + widget.id.toString(),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        });
    if (_response.statusCode == 200) {
      Device deviceFormController = Device.fromJson(jsonDecode(_response.body));
      return deviceFormController;
    } else {
      return null;
    }
  }
}
