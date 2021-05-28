import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class IgnoredDevicesTable extends StatefulWidget {
  IgnoredDevicesTable({
    Key key,
    @required this.devices,
  }) : super(key: key);

  /// List which stores all given devices
  final List<Device> devices;

  _IgnoredDevicesTableState createState() => _IgnoredDevicesTableState();
}

/// Class for working with ignored devices
class _IgnoredDevicesTableState extends State<IgnoredDevicesTable> {
  /// List of displayed devices
  List<Device> _devicesForDisplay;

  /// Variables for handling table
  bool _sortAscending = true;
  Icon _arrowUp = Icon(
    FontAwesomeIcons.arrowUp,
    size: 17,
  );
  Icon _arrowDown = Icon(
    FontAwesomeIcons.arrowDown,
    size: 17,
  );

  @override
  void initState() {
    super.initState();
    _devicesForDisplay = widget.devices;
    _sortDevicesForDisplay();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(160, 60)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0))),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, "/ignoredDeviceOverview");
                  },
                  label: Text(
                    "reload".tr().toString(),
                    style: TextStyle(color: buttonColor),
                  ),
                  icon: Icon(
                    Icons.replay,
                    color: buttonColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  child: SelectableText(
                    'ignoredDevices'.tr().toString(),
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Visibility(
                  visible: adminAccess,
                  child: Container(
                    height: 70,
                    alignment: Alignment.center,
                    child: SelectableText(
                      'searchInformationQuestion'.tr().toString(),
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 16,
                      child:
                          (widget.devices != null && widget.devices.length != 0)
                              ? Column(
                                  children: <Widget>[
                                    _searchBar(),
                                    _listHeader(),
                                    Container(
                                      height: 500,
                                      child: _listForDevices(context),
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
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Header of ignored devices list
  _listHeader() {
    return Container(
      height: 80,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          _sortAscending = !_sortAscending;
          _sortDevicesForDisplay();
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
                    width: 200,
                    child: Row(
                      children: [
                        IconButton(
                          icon: _sortAscending ? _arrowUp : _arrowDown,
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
                Visibility(
                  visible: adminAccess,
                  child: Text(
                    'select'.tr().toString(),
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

  /// Searchbar for searching through divices list
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
            _devicesForDisplay = widget.devices.where((device) {
              var deviceName = device.hostname.toLowerCase();
              return deviceName.contains(text);
            }).toList();
          });
          _sortDevicesForDisplay();
        },
      ),
    );
  }

  /// Function shows dialog for allow data collecting for specific device
  Future _addDeviceDialog(BuildContext context, int _deviceId) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
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
                  contentPadding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  content: Container(
                    width: 300,
                    height: 120,
                    child: Column(
                      children: <Widget>[
                        SelectableText(
                          'searchDeviceInformation'.tr().toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              child: Text(
                                'cancel'.tr().toString(),
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                'confirm'.tr().toString(),
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                _updateDevice(_deviceId.toString());

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

  /// Function that updates a device and activates data collecting
  _updateDevice(String _deviceId) async {
    String _devicesExtension = "devices/$_deviceId";

    Map<String, dynamic> _data = {"collect_info": true};

    await http.put(Uri.parse(url + _devicesExtension),
        body: jsonEncode(_data),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        });

    Navigator.pushReplacementNamed(context, "/newDeviceOverview");
  }

  /// List entries with all devices
  ListView _listForDevices(BuildContext context) {
    return ListView.builder(
      itemCount: _devicesForDisplay.length,
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {
              if (adminAccess && _devicesForDisplay[index].mud_data == null) {
                _addDeviceDialog(context, _devicesForDisplay[index].id);
              }
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _devicesForDisplay[index].hostname,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Visibility(
                      visible: adminAccess,
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.arrowRight,
                          size: 17,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Function for sorting the displayed devices
  _sortDevicesForDisplay() {
    setState(() {
      if (_sortAscending) {
        _devicesForDisplay.sort((a, b) => a.hostname.compareTo(b.hostname));
      } else {
        _devicesForDisplay.sort((a, b) => b.hostname.compareTo(a.hostname));
      }
    });
  }
}
