import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:url_encoder/url_encoder.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/deviceDetailsBuilder.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

// Class that display the details of a specific device and implements functions for updating the device
class DeviceDetails extends StatefulWidget {
  const DeviceDetails({
    Key key,
    @required this.device,
    @required this.rooms,
  }) : super(key: key);

  /// The displayed device that passes through from the deviceDetailsBuilder class
  final Device device;

  /// The displayed rooms which pass through from the deviceDetailsBuilder class
  final List<Room> rooms;

  @override
  _DeviceDetailsState createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  /// Bool for the mouse region widget to implement a hover widget
  bool inRegion = false;

  /// Bool that shows if the dns name table is currently editable
  bool editColumn = false;

  /// Bool for visibility of the reset button
  bool resetButton = false;

  /// A prepared list for the displayed rooms
  List<Room> _roomsForDisplay = [];

  /// The path of the from the user chosen clipart
  String _selectedClipart = allClipArts[0];

  /// The from the user chosen room
  Room _selectedRoom;

  /// The Path to the displayed clipart
  String _clipArtForDisplay = allClipArts[0];

  /// Lists of the dns names from the mud file of this device
  List<String> _aclListForDisplay = [];
  List<String> _aclListCopy = [];

  /// Variables for the sorting of the dns name table
  bool _sortAscending = true;
  bool _sortAscendingRooms = true;
  Icon _arrowUp = Icon(
    FontAwesomeIcons.arrowUp,
    size: 17,
  );
  Icon _arrowDown = Icon(
    FontAwesomeIcons.arrowDown,
    size: 17,
  );

  /// Strings for the name and the new name given by user
  String _name;
  String _newName;

  @override
  void initState() {
    super.initState();
    _generateDnsList();
    _selectedClipart = widget.device.clipart;
    _clipArtForDisplay = widget.device.clipart;
    _roomsForDisplay = widget.rooms;
    _sortRoomsForDisplay();
    _name = widget.device.name;

    if (widget.device.room != null) {
      _selectedRoom = widget.device.room;
    }
  }

  /// url extension to mud routes
  String _updateMUDExtension = "mud/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            size: 17,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/deviceOverview");
          },
        ),
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
                  widget.device.hostname,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),

                SelectableText(
                  _name != null ? _name : "",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),

                Visibility(
                  //The error message shows, if networkError is true
                  visible: adminAccess,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(120, 50)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              buttonColor,
                            ),
                          ),
                          onPressed: () {
                            _renameDialog();
                          },
                          child: Text(
                            "rename".tr().toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),

                Visibility(
                  //The error message shows, if networkError is true
                  visible: adminAccess,
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(120, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          buttonColor,
                        ),
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
                          child: SvgPicture.asset(_clipArtForDisplay,
                              color: Color(int.parse(widget.device.room.color)),
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
                        minimumSize: MaterialStateProperty.all(Size(120, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          buttonColor,
                        ),
                      ),
                      child: Text(
                        "changeClipart".tr().toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        _chooseClipartDialog(context);
                      },
                    ),
                  ),
                ),

                Visibility(
                  // The error message shows, if networkError is true
                  visible: adminAccess,
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(120, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          buttonColor,
                        ),
                      ),
                      child: Text(
                        "changeRoom".tr().toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        _chooseRoomDialog(context);
                      },
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Column(
                  // Check if mobile device, than there are different ways of showing the information
                  children: mobileDevice ? _mobileView() : _desktopView(),
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
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: adminAccess && !editColumn,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(120, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            buttonColor,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            editColumn = !editColumn;
                          });
                        },
                        child: Text(
                          "edit".tr().toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: editColumn,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(120, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            buttonColor,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            editColumn = !editColumn;
                            forwardReset();
                          });
                          _transmitData();
                        },
                        child: Text(
                          "save".tr().toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: editColumn,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(120, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            buttonColor,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            editColumn = !editColumn;
                            forwardReset();
                          });
                        },
                        child: Text(
                          "cancel".tr().toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                    Expanded(
                      flex: 16,
                      child: (widget.device.mud_data.acllist != null &&
                              widget.device.mud_data.acllist.length != 0)
                          ? Column(
                              children: <Widget>[
                                _searchBar(),
                                _listHeader(),
                                Container(
                                  height: 500,
                                  child: _listForAcl(),
                                )
                              ],
                            )
                          : Container(
                              height: 80,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: SelectableText(
                                    "noEntries".tr().toString(),
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
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

  // Function that sort the list of room according to the sortAscendingRooms variable
  _sortRoomsForDisplay() {
    setState(() {
      if (_sortAscendingRooms) {
        _roomsForDisplay.sort((a, b) => a.name.compareTo(b.name));
      } else {
        _roomsForDisplay.sort((a, b) => b.name.compareTo(a.name));
      }
    });
  }

  // Returns a list of widget in case of mobile device for better visibility
  List<Widget> _mobileView() {
    var selectableText1 = SelectableText(
      "ipaddress".tr().toString() + ":",
      style: TextStyle(fontSize: 20),
    );
    var selectableText2 = SelectableText(
      widget.device.ipv4_addr == null
          ? widget.device.ipv6_addr
          : widget.device.ipv4_addr,
      style: TextStyle(fontSize: 18),
    );

    var sizedBox1 = SizedBox(
      height: 20,
    );

    var selectableText3 = SelectableText(
      "lastinteraction".tr().toString() + ":",
      style: TextStyle(fontSize: 20),
    );
    var selectableText4 = SelectableText(
      widget.device.last_interaction,
      style: TextStyle(fontSize: 18),
    );
    var sizedBox2 = SizedBox(
      height: 20,
    );
    var selectableText5 = SelectableText(
      "MUD URL:",
      style: TextStyle(fontSize: 20),
    );
    var selectableText6 = SelectableText(
      widget.device.mud_url,
      textAlign: TextAlign.center,
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

    if (widget.device.mac_addr != null) {
      var selectableText7 = SelectableText(
        'macAddress'.tr().toString() + ":",
        style: TextStyle(fontSize: 20),
      );
      var selectableText8 = SelectableText(
        widget.device.mac_addr,
        style: TextStyle(fontSize: 18),
        onTap: () {
          _launchDocumentation();
        },
      );
      list.add(selectableText7);
      list.add(selectableText8);
    }

    if (widget.device.mud_data.documentation != null) {
      var selectableText7 = SelectableText(
        'documentation'.tr().toString() + ":",
        style: TextStyle(fontSize: 20),
      );
      var selectableText8 = SelectableText(
        widget.device.mud_data.documentation,
        style: TextStyle(fontSize: 18),
        onTap: () {
          _launchDocumentation();
        },
      );
      list.add(selectableText7);
      list.add(selectableText8);
    }

    if (widget.device.mud_data.expiration != null) {
      var sizedBox = SizedBox(
        height: 20,
      );
      var selectableText9 = SelectableText(
        'expiration'.tr().toString() + ":",
        style: TextStyle(fontSize: 20),
      );
      var selectableText10 = SelectableText(
        widget.device.mud_data.expiration,
        style: TextStyle(fontSize: 18),
      );
      list.add(sizedBox);
      list.add(selectableText9);
      list.add(selectableText10);
    }

    if (widget.device.mud_data.last_update != null) {
      var sizedBox = SizedBox(
        height: 20,
      );
      var selectableText11 = SelectableText(
        'lastUpdate'.tr().toString() + ":",
        style: TextStyle(fontSize: 20),
      );
      var selectableText12 = SelectableText(
        widget.device.mud_data.last_update,
        style: TextStyle(fontSize: 18),
      );
      list.add(sizedBox);
      list.add(selectableText11);
      list.add(selectableText12);
    }

    if (widget.device.mud_data.mfg_name != null) {
      var sizedBox = SizedBox(
        height: 20,
      );
      var selectableText13 = SelectableText(
        'manufacturer'.tr().toString() + ":",
        style: TextStyle(fontSize: 20),
      );
      var selectableText14 = SelectableText(
        widget.device.mud_data.mfg_name,
        style: TextStyle(fontSize: 18),
      );
      list.add(sizedBox);
      list.add(selectableText13);
      list.add(selectableText14);
    }

    if (widget.device.mud_data.model_name != null) {
      var sizedBox = SizedBox(
        height: 20,
      );
      var selectableText15 = SelectableText(
        'model'.tr().toString() + ":",
        style: TextStyle(fontSize: 20),
      );
      var selectableText16 = SelectableText(
        widget.device.mud_data.model_name,
        style: TextStyle(fontSize: 18),
      );
      list.add(sizedBox);
      list.add(selectableText15);
      list.add(selectableText16);
    }

    if (widget.device.mud_data.systeminfo != null) {
      var sizedBox = SizedBox(
        height: 20,
      );
      var selectableText17 = SelectableText(
        'systeminfo'.tr().toString() + ":",
        style: TextStyle(fontSize: 20),
      );
      var selectableText18 = SelectableText(
        widget.device.mud_data.systeminfo,
        style: TextStyle(fontSize: 18),
      );
      list.add(sizedBox);
      list.add(selectableText17);
      list.add(selectableText18);
    }

    return list;
  }

  // Return a list of widget in case of desktop device for better visibility
  List<Widget> _desktopView() {
    var column1 = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableText(
                "ipaddress".tr().toString() + ":",
                style: TextStyle(fontSize: 20),
              ),
              SelectableText(
                widget.device.ipv4_addr == null
                    ? widget.device.ipv6_addr
                    : widget.device.ipv4_addr,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableText(
                "MUD URL:",
                style: TextStyle(fontSize: 20),
              ),
              SelectableText(
                widget.device.mud_url,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
                onTap: () {
                  _launchMUDURL();
                },
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.device.mud_data.mfg_name != null
                ? [
                    SizedBox(
                      height: 50,
                    ),
                    SelectableText(
                      'manufacturer'.tr().toString() + ":",
                      style: TextStyle(fontSize: 20),
                    ),
                    SelectableText(
                      widget.device.mud_data.mfg_name,
                      style: TextStyle(fontSize: 18),
                    )
                  ]
                : [
                    Container(),
                  ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.device.mud_data.model_name != null
                ? [
                    SizedBox(
                      height: 50,
                    ),
                    SelectableText(
                      'model'.tr().toString() + ":",
                      style: TextStyle(fontSize: 20),
                    ),
                    SelectableText(
                      widget.device.mud_data.model_name,
                      style: TextStyle(fontSize: 18),
                    )
                  ]
                : [
                    Container(),
                  ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.device.mud_data.systeminfo != null
                ? [
                    SizedBox(
                      height: 50,
                    ),
                    SelectableText(
                      "systeminfo".tr().toString() + ":",
                      style: TextStyle(fontSize: 20),
                    ),
                    SelectableText(
                      widget.device.mud_data.systeminfo,
                      style: TextStyle(fontSize: 18),
                    )
                  ]
                : [
                    Container(),
                  ],
          ),
        ],
      ),
    );

    var column2 = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.device.mac_addr != null
                    ? [
                        SelectableText(
                          "macAddress".tr().toString() + ":",
                          style: TextStyle(fontSize: 20),
                        ),
                        SelectableText(
                          widget.device.mac_addr,
                          style: TextStyle(fontSize: 18),
                        )
                      ]
                    : [
                        Container(),
                      ],
              ),
              SizedBox(
                height: 50,
              ),
              SelectableText(
                "lastinteraction".tr().toString() + ":",
                style: TextStyle(fontSize: 20),
              ),
              SelectableText(
                formatTimeAgo(widget.device.last_interaction),
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.device.mud_data.expiration != null
                ? [
                    SizedBox(
                      height: 50,
                    ),
                    SelectableText(
                      'expiration'.tr().toString() + ":",
                      style: TextStyle(fontSize: 20),
                    ),
                    SelectableText(
                      formatTimeAgo(widget.device.mud_data.expiration),
                      style: TextStyle(fontSize: 18),
                    )
                  ]
                : [
                    Container(),
                  ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.device.mud_data.last_update != null
                ? [
                    SizedBox(
                      height: 50,
                    ),
                    SelectableText(
                      'lastUpdate'.tr().toString() + ":",
                      style: TextStyle(fontSize: 20),
                    ),
                    SelectableText(
                      formatTimeAgo(widget.device.mud_data.last_update),
                      style: TextStyle(fontSize: 18),
                    )
                  ]
                : [
                    Container(),
                  ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.device.mud_data.documentation != null
                ? [
                    SizedBox(
                      height: 50,
                    ),
                    SelectableText(
                      'documentation'.tr().toString() + ":",
                      style: TextStyle(fontSize: 20),
                    ),
                    SelectableText(
                      widget.device.mud_data.documentation,
                      style: TextStyle(fontSize: 18),
                      onTap: () {
                        _launchDocumentation();
                      },
                    )
                  ]
                : [
                    Container(),
                  ],
          )
        ],
      ),
    );

    var row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        column1,
        // SizedBox(
        //   width: 200,
        // ),
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

  // Formatter for time stamps
  String formatTimeAgo(String time) {
    DateTime dateTime = DateTime.parse(time);
    Duration diff = DateTime.now().difference(dateTime);

    if (diff.inDays >= 1) {
      return '${diff.inDays} ' + "daysAgo".tr().toString();
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} ' + "hoursAgo".tr().toString();
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} ' + "minutesAgo".tr().toString();
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} ' + "secondsAgo".tr().toString();
    } else if (diff.inDays < 0) {
      Duration positiveTime = diff.abs();
      return "in".tr().toString() +
          ' ${positiveTime.inDays} ' +
          "days".tr().toString();
    } else if (diff.inHours < 0) {
      Duration positiveTime = diff.abs();
      return "in".tr().toString() +
          ' ${positiveTime.inHours} ' +
          "hours".tr().toString();
    } else if (diff.inMinutes < 0) {
      Duration positiveTime = diff.abs();
      return "in".tr().toString() +
          ' ${positiveTime.inMinutes} ' +
          "minutes".tr().toString();
    } else if (diff.inSeconds < 0) {
      Duration positiveTime = diff.abs();
      return "in".tr().toString() +
          ' ${positiveTime.inSeconds} ' +
          "seconds".tr().toString();
    } else {
      return 'justNow'.tr().toString();
    }
  }

  // This method launch the documentation of the profils, if it is not possible there will be thrown an error
  _launchDocumentation() async {
    if (await canLaunch(widget.device.mud_data.documentation)) {
      await launch(widget.device.mud_data.documentation);
    } else {
      throw 'Could not launch documentation';
    }
  }

  // This method launchs the MUDURL to the device, these URLs are the profils for the devices that are added to the app
  // if it not possible it will be thrown an error
  _launchMUDURL() async {
    if (await canLaunch(widget.device.mud_url)) {
      await launch(widget.device.mud_url);
    } else {
      throw 'Could not launch mud url';
    }
  }

  // This method sends the MUD-Profile-Data to the controller
  Future _transmitData() async {
    Map<String, dynamic> test = widget.device.mud_data.toJson();

    var test2 = test["acl_override"];

    Map<String, dynamic> data = {"acl_override": test2};
    String _urlExtension = "?mud_url=";
    String _urlEncodedMudUrl =
        urlEncode(text: widget.device.mud_data.url).toString();
    await http.put(
        url + _updateMUDExtension + _urlExtension + _urlEncodedMudUrl,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        },
        body: jsonEncode(data));
  }

  // Shows the dialog for renaming the device
  void _renameDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          content: Container(
            width: 300,
            height: 175,
            child: Column(
              children: [
                SelectableText("renameDisclaimer".tr().toString()),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'name'.tr().toString(),
                  ),
                  onChanged: (text) {
                    _newName = text;
                  },
                ),
                SizedBox(
                  height: 20,
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
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // dismiss dialog
                      },
                    ),
                    TextButton(
                      child: Text(
                        "save".tr().toString(),
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        Map<String, dynamic> data = {"name": _newName};
                        String _urlExtension = "devices/${widget.device.id}";
                        http.put(url + _urlExtension,
                            headers: {
                              "Content-Type": "application/json",
                              "Authorization": "Bearer $jwtToken"
                            },
                            body: jsonEncode(data));
                        setNewName(_newName);
                        Navigator.of(context).pop(); // dismiss dialog
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Updates UI
  setNewName(String name) {
    setState(() {
      _name = name;
    });
  }

  // Dialog for resetting the mud file of this device
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
                          fontSize: 18,
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
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () async {
                        Map<String, dynamic> data = {"acl_override": []};
                        String _urlExtension = "?mud_url=";
                        String _urlEncoded =
                            urlEncode(text: widget.device.mud_url).toString();
                        await http.put(
                            url +
                                _updateMUDExtension +
                                _urlExtension +
                                _urlEncoded,
                            headers: {
                              "Content-Type": "application/json",
                              "Authorization": "Bearer $jwtToken"
                            },
                            body: jsonEncode(data));
                        Navigator.of(context).pop(); // dismiss dialog
                        forwardReset();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Reloads the page
  void forwardReset() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DeviceDetailsBuilder(id: widget.device.id),
      ),
    );
  }

  // Implements the header of the dns name table
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

  // Implements the search bar of the dns name table
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

  // Implements the dns name list of the dns name table
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

  // Processes the information in the device for the dns name list
  _generateDnsList() {
    _aclListCopy = [];
    if (widget.device.mud_data.acl_override.isEmpty) {
      widget.device.mud_data.acllist.forEach((aclElement) {
        aclElement.ace.forEach((aceElement) {
          if (aceElement.matches.dnsname != null) {
            _aclListCopy.add(aceElement.matches.dnsname);
          }
        });
      });
    } else {
      widget.device.mud_data.acl_override.forEach((aclElement) {
        aclElement.ace.forEach((aceElement) {
          if (aceElement.matches.dnsname != null) {
            _aclListCopy.add(aceElement.matches.dnsname);
          }
        });
      });
    }
    _aclListCopy = _aclListCopy.toSet().toList();
    _aclListForDisplay = List.from(_aclListCopy);
  }

  // Function for sorting the dns name list
  _sortAclListForDisplay() {
    setState(() {
      if (_sortAscending) {
        _aclListForDisplay.sort((a, b) => a.compareTo(b));
      } else {
        _aclListForDisplay.sort((a, b) => b.compareTo(a));
      }
    });
  }

  // Dialog for updating the room of the device
  _chooseRoomDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // Here are displayed all rooms
        return StatefulBuilder(
          builder: (context, setState) {
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
                    height: 450,
                    child: Column(
                      children: <Widget>[
                        /// here is the searchBar
                        Padding(
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
                                _roomsForDisplay = widget.rooms.where((room) {
                                  var roomName = room.name.toLowerCase();
                                  return roomName.contains(text);
                                }).toList();
                              });
                              setState(() {
                                if (_sortAscendingRooms) {
                                  _roomsForDisplay
                                      .sort((a, b) => a.name.compareTo(b.name));
                                } else {
                                  _roomsForDisplay
                                      .sort((a, b) => b.name.compareTo(a.name));
                                }
                              });
                            },
                          ),
                        ),

                        /// Here is the ListHeader
                        Container(
                          height: 80,
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onTap: () {
                              _sortAscendingRooms = !_sortAscendingRooms;
                              setState(() {
                                if (_sortAscendingRooms) {
                                  _roomsForDisplay
                                      .sort((a, b) => a.name.compareTo(b.name));
                                } else {
                                  _roomsForDisplay
                                      .sort((a, b) => b.name.compareTo(a.name));
                                }
                              });
                            },
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              icon: _sortAscendingRooms
                                                  ? _arrowUp
                                                  : _arrowDown,
                                            ),
                                            Text(
                                              'name'.tr().toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'color'.tr().toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// Here the real List begins
                        Container(
                          height: 250,
                          child: ListView.builder(
                            itemCount: _roomsForDisplay.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 80,
                                child: InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedRoom = _roomsForDisplay[index];
                                    });
                                  },
                                  child: Card(
                                    shape:
                                        _selectedRoom == _roomsForDisplay[index]
                                            ? new RoundedRectangleBorder(
                                                side: new BorderSide(
                                                    color: buttonColor,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(4.0))
                                            : new RoundedRectangleBorder(),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              _roomsForDisplay[index].name,
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: Color(int.parse(
                                                        _roomsForDisplay[index]
                                                            .color)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                // dismiss dialog
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                "Übernehmen",
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                _changeRoom();
                                Navigator.of(context).pop();
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
          },
        );
      },
    );
  }

  // Updates the room of the device at the controller
  void _changeRoom() {
    String _deviceId = widget.device.id.toString();
    String _updateDeviceExtension = "devices/$_deviceId";

    Map<String, dynamic> data = {
      "room_id": _selectedRoom.id,
    };
    http.put(
      url + _updateDeviceExtension,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwtToken"
      },
      body: jsonEncode(data),
    );
    forwardReset();
  }

  // Dialog for choosing a new clipart for the device
  Future _chooseClipartDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // Here are displayed all cliparts
        return StatefulBuilder(
          builder: (context, setState) {
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
                              child: SvgPicture.asset(
                                _selectedClipart,
                                color:
                                    Color(int.parse(widget.device.room.color)),
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
                                  child: SvgPicture.asset(
                                    clipArt,
                                    semanticsLabel: 'phone',
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedClipart = clipArt;
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
                                  fontSize: 18,
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
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                _changeClipart();
                                changeClipArtForDisplay();
                                // dismiss dialog
                                Navigator.of(context).pop();
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
          },
        );
      },
    );
  }

  // Updates UI
  void changeClipArtForDisplay() {
    setState(() {
      _clipArtForDisplay = _selectedClipart;
    });
  }

  // Updates the clipart at the controller
  void _changeClipart() {
    String _deviceId = widget.device.id.toString();
    String _updateDeviceExtension = "devices/$_deviceId";

    Map<String, dynamic> data = {
      "clipart": _selectedClipart,
    };
    http.put(url + _updateDeviceExtension,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        },
        body: jsonEncode(data));
  }

  // Dialog for deleting a dns name from the table
  void _deleteDNSName(String accessControlEntry) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          title: SelectableText(
            "attention".tr().toString(),
          ),
          content: Container(
            width: 300,
            height: 175,
            child: Column(
              children: [
                SelectableText(
                  "deleteDNSNameDisclaimer".tr().toString(),
                ),
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
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        // dismiss dialog
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                        "delete".tr().toString(),
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            // If acl_override is empty a copy of acllist gets put at acl_override
                            if (widget.device.mud_data.acl_override.isEmpty) {
                              widget.device.mud_data.acl_override =
                                  List.from(widget.device.mud_data.acllist);
                            }

                            // Part that deletes the dns name from the list of all dns names in this profile
                            widget.device.mud_data.acl_override
                                .forEach((aclElement) {
                              aclElement.ace.forEach((aceElement) {
                                if (aceElement.matches.dnsname ==
                                    accessControlEntry) {
                                  _aclListForDisplay
                                      .remove(aceElement.matches.dnsname);
                                }
                              });
                            });

                            // Part that deletes the entry of the ace which dns name is selected
                            for (int i = 0;
                                i < widget.device.mud_data.acl_override.length;
                                i++) {
                              for (int j = 0;
                                  j <
                                      widget.device.mud_data.acl_override[i].ace
                                          .length;
                                  j++) {
                                if (widget.device.mud_data.acl_override[i]
                                        .ace[j].matches.dnsname ==
                                    accessControlEntry) {
                                  widget.device.mud_data.acl_override[i].ace
                                      .removeAt(j);
                                  //widget.device.mud_data.acl_override[i].ace[j].matches.dnsname = null;

                                }
                              }
                            }
                          },
                        );
                        // dismiss dialog
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Additional explanation text for the dns name list
  Visibility _expertModeText(BuildContext context) {
    return Visibility(
      visible: !expertMode,
      child:
          //if mobile device, then icon button with dialog, else icon with hover effect
          mobileDevice
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
                          content: Text("explanationDNSNames".tr().toString()),
                          actions: [
                            TextButton(
                              child: Text(
                                "Ok!",
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(); // dismiss dialog
                              },
                            )
                          ],
                        );
                      },
                    );
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

  //Function that shows the overlay element
  showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    overlayState.insert(overlayEntry);
  }

  //Function for closing the overlay element
  closeOverlay() {
    overlayEntry.remove();
  }

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
    ),
  );
}
