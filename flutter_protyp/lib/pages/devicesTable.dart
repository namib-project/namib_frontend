import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/deviceDetails.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_protyp/data/room.dart';

class DevicesTable extends StatefulWidget {
  const DevicesTable({
    Key key,
    @required this.devices,
  }) : super(key: key);

  /// List which stores all given devices
  final List<Device> devices;

  /// TODO: Maybe add final List<Room> rooms

  _DevicesTableState createState() => _DevicesTableState();
}

class _DevicesTableState extends State<DevicesTable> {
  List<Device> _devicesCopy = [];
  List<List<Device>> _devicesForDisplay = [];

  List<Room> _uniqueRooms = [];
  List<Room> _selectedRooms = [];

  String _searchWord = "";
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
      _devicesCopy = widget.devices;

      /// to remove all the duplicates to get all rooms only once
      for (Device d in _devicesCopy) {
        Room room = new Room(d.roomname, d.roomcolor);
        _uniqueRooms.add(room);
      }
      final _allRooms = _uniqueRooms.map((e) => e.roomname).toSet();
      _uniqueRooms.retainWhere((x) => _allRooms.remove(x.roomname));

      _sortUniqueRooms();
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
                                      height: 500,
                                      child: _listForDevicesRooms(context),
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

  _listForDevicesRooms(BuildContext context) {
    return ListView.builder(
      itemCount: _devicesForDisplay.length,
      itemBuilder: (context, index) {
        try {
          return Theme(
            data: ThemeData(
              primaryColor:
                  Color(int.parse(_devicesForDisplay[index][0].roomcolor)),
              accentColor:
                  Color(int.parse(_devicesForDisplay[index][0].roomcolor)),
              hintColor:
                  Color(int.parse(_devicesForDisplay[index][0].roomcolor)),
            ),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                _devicesForDisplay[index][0].roomname,
                style: TextStyle(
                  color:
                      Color(int.parse(_devicesForDisplay[index][0].roomcolor)),
                  fontSize: 20,
                ),
              ),
              children: <Widget>[
                Column(
                  children: _listForDevices(context, index),
                ),
              ],
            ),
          );
        } catch (exception) {
          return Container();
        }
      },
    );
  }

  _roomFilter() {
    return ExpansionTile(
      title: Text(
        "Raumfilter",
        style: TextStyle(
          color: primaryColor,
          fontSize: 20,
        ),
      ),
      children: <Widget>[
        (_uniqueRooms != null && _uniqueRooms.length != 0)
            ? Column(
                children: <Widget>[
                  Container(
                    height: _uniqueRooms.length * 50.0,
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
      itemCount: _uniqueRooms.length,
      itemBuilder: (context, index) {
        return Container(
          height: 50,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {
              setState(() {
                _selectedRooms.contains(_uniqueRooms[index])
                    ? _selectedRooms.remove(_uniqueRooms[index])
                    : _selectedRooms.add(_uniqueRooms[index]);
                _sortDevicesForDisplay();
                _searchWithSearchWord();
                _filterDevicesWithRoom();
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
                    value: _selectedRooms.contains(_uniqueRooms[index]),
                    onChanged: (bool value) {
                      setState(() {
                        _selectedRooms.contains(_uniqueRooms[index])
                            ? _selectedRooms.remove(_uniqueRooms[index])
                            : _selectedRooms.add(_uniqueRooms[index]);
                        _sortDevicesForDisplay();
                        _searchWithSearchWord();
                        _filterDevicesWithRoom();
                      });
                    },
                  ),
                  Text(
                    _uniqueRooms[index].roomname,
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
                  "Raum",
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
          _searchWord = text;
          _searchWithSearchWord();
          _filterDevicesWithRoom();
          _sortDevicesForDisplay();
        },
      ),
    );
  }

  List<Widget> _listForDevices(BuildContext context, int index0) {
    List<Widget> _columnContent = [];

    for (Device d in _devicesForDisplay[index0]) {
      _columnContent.add(ListTile(
        title: Container(
          height: 80,
          child: InkWell(
            hoverColor: Color(int.parse(d.roomcolor)),
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeviceDetails(
                    device: d,
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(
                    int.parse(d.roomcolor),
                  ),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      d.mud_data.systeminfo,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      d.mud_url,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      d.roomname,
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
      ));
    }
    return _columnContent;
  }

  _filterDevicesWithRoom() {
    if (_selectedRooms.isNotEmpty && _selectedRooms != null) {
      List<Device> _devicesList = [];
      for (Room r in _selectedRooms) {
        for (Device d in _devicesCopy) {
          if (d.roomname == r.roomname) {
            _devicesList.add(d);
          }
        }
      }
      _devicesCopy = _devicesList;
    }
    setState(() {
      _createDevicesForDisplay();
    });
  }

  _searchWithSearchWord() {
    _searchWord = _searchWord.toLowerCase();
    setState(() {
      _devicesCopy = widget.devices.where((device) {
        var deviceName = device.mud_data.systeminfo.toLowerCase();
        return deviceName.contains(_searchWord);
      }).toList();
      _createDevicesForDisplay();
    });
  }

  _sortDevicesForDisplay() {
    setState(() {
      if (_sortAscending) {
        _devicesCopy.sort(
            (a, b) => a.mud_data.systeminfo.compareTo(b.mud_data.systeminfo));
      } else {
        _devicesCopy.sort(
            (a, b) => b.mud_data.systeminfo.compareTo(a.mud_data.systeminfo));
      }
      _createDevicesForDisplay();
    });
  }

  _sortUniqueRooms() {
    setState(() {
      _uniqueRooms.sort((a, b) {
        return a.roomname.toLowerCase().compareTo(b.roomname.toLowerCase());
      });
    });
  }

  _createDevicesForDisplay() {
    _devicesForDisplay = [];

    for (Room r in _uniqueRooms) {
      List<Device> _devicesWithRoom = [];
      for (Device d in _devicesCopy) {
        if (d.roomname == r.roomname) {
          _devicesWithRoom.add(d);
        }
      }
      _devicesForDisplay.add(_devicesWithRoom);
    }
  }
}
