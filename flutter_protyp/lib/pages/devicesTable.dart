import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:flutter_protyp/pages/deviceDetailsBuilder.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// This class implements the functions to generate the tableview for the devices

class DevicesTable extends StatefulWidget {
  const DevicesTable({
    Key key,
    @required this.devices,
    @required this.rooms,
  }) : super(key: key);

  /// List which stores all given devices
  final List<Device> devices;
  final List<Room> rooms;

  _DevicesTableState createState() => _DevicesTableState();
}

//Class for user registration, will only be used at the first usage
class _DevicesTableState extends State<DevicesTable> {
  /// Lists which stores devices
  List<Device> _devicesCopy = [];
  List<List<Device>> _devicesForDisplay = [];

  /// Lists which stores rooms
  List<Room> _uniqueRooms = [];
  List<Room> _selectedRooms = [];

  /// Word for searching
  String _searchWord = "";

  /// For sorting the table
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
    _devicesCopy = widget.devices;
    _uniqueRooms = widget.rooms;
    _sortRooms();
    _sortDevicesForDisplay();
    _createDevicesForDisplay();
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

  /// Creates the table with all entries
  _listForDevicesRooms(BuildContext context) {
    return ListView.builder(
      itemCount: _devicesForDisplay.length,
      itemBuilder: (context, index) {
        try {
          return ExpansionTile(
            initiallyExpanded: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(
                        int.parse(_devicesForDisplay[index][0].room.color)),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  _devicesForDisplay[index][0].room.name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            children: <Widget>[
              Column(
                children: _listForDevices(context, index),
              ),
            ],
          );
        } catch (exception) {
          return Container();
        }
      },
    );
  }

  /// Scans for specific room
  _roomFilter() {
    return ExpansionTile(
      title: Text(
        'roomFilter'.tr().toString(),
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

  /// List with room names in it
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
                _createDevicesForDisplay();
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
                        _createDevicesForDisplay();
                      });
                    },
                  ),
                  Text(
                    _uniqueRooms[index].name,
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

  /// This function creates the list-header which is displayed above the table
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
          _createDevicesForDisplay();
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
                          'hostname'.tr().toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
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
      ),
    );
  }

  /// This is a simple searchbar to scan for objects
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
          _searchWord = text;
          _searchWithSearchWord();
          _filterDevicesWithRoom();
          _sortDevicesForDisplay();
          _createDevicesForDisplay();
        },
      ),
    );
  }

  /// This functions is for display the table
  List<Widget> _listForDevices(BuildContext context, int index0) {
    List<Widget> _columnContent = [];

    for (Device d in _devicesForDisplay[index0]) {
      _columnContent.add(ListTile(
        title: Container(
          height: 80,
          child: InkWell(
            hoverColor: Color(int.parse(d.room.color)),
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeviceDetailsBuilder(
                    id: d.id,
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(
                    int.parse(d.room.color),
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
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              d.clipart,
                              semanticsLabel: 'phone',
                              height: 50,
                              width: 50,
                              color: Color(
                                int.parse(d.room.color),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              d.hostname,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      d.name,
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

  /// Scans list by room name
  _filterDevicesWithRoom() {
    if (_selectedRooms.isNotEmpty && _selectedRooms != null) {
      List<Device> _devicesList = [];
      for (Room r in _selectedRooms) {
        for (Device d in _devicesCopy) {
          if (d.room.name == r.name) {
            _devicesList.add(d);
          }
        }
      }
      _devicesCopy = _devicesList;
    }
  }

  /// Scans list by any word
  _searchWithSearchWord() {
    _searchWord = _searchWord.toLowerCase();
    setState(() {
      _devicesCopy = widget.devices.where((device) {
        var deviceHostName = device.hostname.toLowerCase();
        var deviceName = device.name.toLowerCase();
        return deviceHostName.contains(_searchWord) ||
            deviceName.contains(_searchWord);
      }).toList();
    });
  }

  /// Sorts the list by hostname
  _sortDevicesForDisplay() {
    setState(() {
      if (_sortAscending) {
        _devicesCopy.sort((a, b) => a.hostname.compareTo(b.hostname));
      } else {
        _devicesCopy.sort((a, b) => b.hostname.compareTo(a.hostname));
      }
    });
  }

  /// Sort by rooms
  _sortRooms() {
    setState(() {
      _uniqueRooms.sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    });
  }

  /// Function that builds table for create device
  _createDevicesForDisplay() {
    _devicesForDisplay = [];

    for (Device d in _devicesCopy) {
      if (d.room == null) {
        _uniqueRooms.add(Room.roomConstructor(
            -1, 'notAssigned'.tr().toString(), "0xFFB00020"));
        break;
      }
    }

    for (Device d in _devicesCopy) {
      if (d.clipart == null) {
        d.clipart = allClipArts[0];
      }
    }

    for (Device d in _devicesCopy) {
      if (d.name == null) {
        d.name = "";
      }
    }

    for (Room r in _uniqueRooms) {
      List<Device> _devicesWithRoom = [];
      for (Device d in _devicesCopy) {
        if (d.room != null) {
          if (d.room.name == r.name) {
            _devicesWithRoom.add(d);
          }
        } else {
          d.room = Room.roomConstructor(
              -1, 'notAssigned'.tr().toString(), "0xFFB00020");
          if ('notAssigned'.tr().toString() == r.name) {
            _devicesWithRoom.add(d);
          }
        }
      }
      _devicesForDisplay.add(_devicesWithRoom);
    }
  }
}
