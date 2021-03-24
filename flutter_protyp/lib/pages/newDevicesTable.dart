import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/newDevice.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// This class for process after user registration, will only be used at the first usage

class NewDevicesTable extends StatefulWidget {
  NewDevicesTable({
    Key key,
    @required this.devices,
  }) : super(key: key);

  /// List which stores all given devices
  final List<Device> devices;

  _NewDevicesTableState createState() => _NewDevicesTableState();
}


class _NewDevicesTableState extends State<NewDevicesTable> {
  List<Device> _devicesForDisplay = List<Device>();
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
    setState(() {
      _devicesForDisplay = widget.devices;
      _sortDevicesForDisplay();
    });
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
                Container(
                  height: 50,
                  child: SelectableText(
                    'Unverwaltete Geräte'.tr().toString(),
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: SelectableText(
                    "Wählen Sie ein Gerät zum Hinzufügen",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20,
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
                                      height: 250,
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

  // This function sorts the devices-table on button hit
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
                          "Name",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "Auswählen",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Here is a searchbar to search for devices
  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Suche...",
          suffixIcon: Icon(
            FontAwesomeIcons.search,
          ),
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _devicesForDisplay = widget.devices.where((device) {
              var deviceName = device.mud_data.systeminfo;
              return deviceName.contains(text);
            }).toList();
          });
          _sortDevicesForDisplay();
        },
      ),
    );
  }

  // Here is the display-method for the devices-table
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
              if (adminAccess) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewDevice(),
                    ));
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
                      _devicesForDisplay[index].mud_data.systeminfo,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.arrowRight,
                        size: 17,
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

  // This function sorts the devices-table by mud-data
  _sortDevicesForDisplay() {
    setState(() {
      if (_sortAscending) {
        _devicesForDisplay.sort(
            (a, b) => a.mud_data.systeminfo.compareTo(b.mud_data.systeminfo));
      } else {
        _devicesForDisplay.sort(
            (a, b) => b.mud_data.systeminfo.compareTo(a.mud_data.systeminfo));
      }
    });
  }
}
