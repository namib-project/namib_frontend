import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/deviceDetails.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DevicesTable extends StatefulWidget {
  const DevicesTable({
    Key key,
    @required this.devices,
  }) : super(key: key);

  /// List which stores all given devices
  final List<Device> devices;

  _DevicesTableState createState() => _DevicesTableState();
}

//Class for user registration, will only be used at the first usage
class _DevicesTableState extends State<DevicesTable> {
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

  /// TODO: existing Rooms have to go in this list or make Room Objects
  List<String> _roomNames = ["Küche", "Wohnzimmer", "Flur", "Badezimmer"];
  List<String> _selectedRooms = [];

  @override
  void initState() {
    setState(() {
      _devicesForDisplay = widget.devices;
      _sortDevicesForDisplay();
      _sortRoomNames();
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
                                    _roomFilter(),
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _roomFilter() {
    return ExpansionTile(
      title: Text("Raumfilter",
          style: TextStyle(
            color: primaryColor,
            fontSize: 20,
          )),
      children: <Widget>[
        (_roomNames != null && _roomNames.length != 0)
            ? Column(
                children: <Widget>[
                  Container(
                    height: _roomNames.length * 50.0,
                    child: _listForRoomNames(),
                  )
                ],
              )
            : Container(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: SelectableText(
                    "noEntries".tr().toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  _listForRoomNames() {
    return ListView.builder(
      itemCount: _roomNames.length,
      itemBuilder: (context, index) {
        return Container(
          height: 50,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {
              setState(() {
                _selectedRooms.contains(_roomNames[index])
                    ? _selectedRooms.remove(_roomNames[index])
                    : _selectedRooms.add(_roomNames[index]);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    activeColor: buttonColor,
                    value: _selectedRooms.contains(_roomNames[index]),
                    onChanged: (bool value) {},
                  ),
                  Text(
                    _roomNames[index],
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                  "MUD",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Edit",
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeviceDetails(
                    device: _devicesForDisplay[index],
                  ),
                ),
              );
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
                    Text(
                      _devicesForDisplay[index].mud_url,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.cog,
                        size: 20,
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

  _sortRoomNames() {
    _roomNames.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
  }
}
