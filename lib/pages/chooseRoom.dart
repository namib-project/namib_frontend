import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/data/device_mud/mudGuess.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'chooseMudDataTableOverview.dart';

/// This class is for choosing a room for device

class RoomTable extends StatefulWidget {
  const RoomTable({
    Key key,
    @required this.rooms,
    @required this.device,
    @required this.mudGuesses,
  }) : super(key: key);

  /// List which stores all given devices
  final List<Room> rooms;
  final List<MudGuess> mudGuesses;

  /// A new device
  final Device device;

  _RoomTableState createState() => _RoomTableState();
}

//Class for choosing a room, will only be used at the first usage
class _RoomTableState extends State<RoomTable> {
  /// List with rooms
  List<Room> _uniqueRooms = [];
  List<Room> _roomsForDisplay;

  /// A room
  Room _chosenRoom;

  /// A new device
  Device _newDevice;

  /// to get the value to create a room with color use: currentColor.value.toString()
  Color currentColor = Color(4289724448);

  /// For sorting
  bool _sortAscending = true;
  Icon _arrowUp = Icon(
    FontAwesomeIcons.arrowUp,
    size: 17,
  );
  Icon _arrowDown = Icon(
    FontAwesomeIcons.arrowDown,
    size: 17,
  );

  /// Define some custom colors for the custom picker segment.
  /// The 'guide' color values are from
  /// https://material.io/design/color/the-color-system.html#color-theme-creation
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  /// Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };

  /// Changes the current color
  void changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  @override
  void initState() {
    super.initState();
    _uniqueRooms = widget.rooms;

    /// to remove all the duplicates to get all rooms only once
    final _allRooms = _uniqueRooms.map((e) => e.name).toSet();
    _uniqueRooms.retainWhere((x) => _allRooms.remove(x.name));
    _roomsForDisplay = _uniqueRooms;
    _sortRoomsForDisplay();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
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
              children: [
                Container(
                  height: 70,
                  child: SelectableText(
                    'roomChoice'.tr().toString(),
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
                    'selectRoom'.tr().toString(),
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
                      child: (_uniqueRooms != null && _uniqueRooms.length != 0)
                          ? Column(
                              children: <Widget>[
                                _searchBar(),
                                _listHeader(),
                                Container(
                                  height: 250,
                                  child: _listForRooms(context),
                                ),
                                _bottomButtons(),
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
          _sortRoomsForDisplay();
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
                Text(
                  'select'.tr().toString(),
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
          text = text.toLowerCase();
          setState(() {
            _roomsForDisplay = _uniqueRooms.where((room) {
              var roomName = room.name.toLowerCase();
              return roomName.contains(text);
            }).toList();
          });
          _sortRoomsForDisplay();
        },
      ),
    );
  }

  /// This functions is for display the table
  ListView _listForRooms(BuildContext context) {
    return ListView.builder(
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
                _chosenRoom == _roomsForDisplay[index]
                    ? _chosenRoom = null
                    : _chosenRoom = _roomsForDisplay[index];
              });
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color(
                                  int.parse(_roomsForDisplay[index].color)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Checkbox(
                          activeColor: buttonColor,
                          value: _chosenRoom == _roomsForDisplay[index],
                          onChanged: (bool value) {
                            setState(() {
                              _chosenRoom == _roomsForDisplay[index]
                                  ? _chosenRoom = null
                                  : _chosenRoom = _roomsForDisplay[index];
                            });
                          },
                        ),
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

  /// Buttons for actions to do
  _bottomButtons() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            child: Text(
              'cancel'.tr().toString(),
              style: TextStyle(
                color: buttonColor,
                fontSize: 18,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/deviceOverview");
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
              if (_chosenRoom != null) {
                _newDevice = widget.device;
                _newDevice.room = _chosenRoom;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseMudDataTable(
                      device: _newDevice,
                      mudGuessList: widget.mudGuesses,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseMudDataTable(
                      device: widget.device,
                      mudGuessList: widget.mudGuesses,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  /// Sorting the list
  _sortRoomsForDisplay() {
    setState(() {
      if (_sortAscending) {
        _roomsForDisplay.sort((a, b) => a.name.compareTo(b.name));
      } else {
        _roomsForDisplay.sort((a, b) => b.name.compareTo(a.name));
      }
    });
  }
}
