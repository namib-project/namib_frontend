import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/deviceDetails.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_protyp/data/room.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class RoomTable extends StatefulWidget {
  const RoomTable({
    Key key,
    @required this.rooms,
  }) : super(key: key);

  /// List which stores all given devices
  final List<Room> rooms;

  _RoomTableState createState() => _RoomTableState();
}

//Class for user registration, will only be used at the first usage
class _RoomTableState extends State<RoomTable> {
  List<Room> _uniqueRooms = [];
  List<Room> _roomsForDisplay;
  Room chosenRoom;
  String newRoomName;

  /// to get the value to create a room with color use: currentColor.value.toString()
  Color currentColor = Color(4289724448);

  bool _sortAscending = true;
  Icon _arrowUp = Icon(
    FontAwesomeIcons.arrowUp,
    size: 17,
  );
  Icon _arrowDown = Icon(
    FontAwesomeIcons.arrowDown,
    size: 17,
  );

  // Define some custom colors for the custom picker segment.
  // The 'guide' color values are from
  // https://material.io/design/color/the-color-system.html#color-theme-creation
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
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

  void changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  @override
  void initState() {
    setState(() {
      _uniqueRooms = widget.rooms;

      /// to remove all the duplicates to get all rooms only once
      final allRoomNames = _uniqueRooms.map((e) => e.roomname).toSet();
      _uniqueRooms.retainWhere((x) => allRoomNames.remove(x.roomname));

      _roomsForDisplay = _uniqueRooms;
      _sortRoomsForDisplay();
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
                    "Raumwahl",
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
                    "Wählen Sie einen Raum",
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
                                Container(
                                  height: 70,
                                  alignment: Alignment.center,
                                  child: SelectableText(
                                    "Oder erstellen Sie einen neuen",
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                _newRoomDialog(),
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

  _newRoomDialog() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Container(
            height: 50,
            width: 280,
            child: TextField(
              obscureText: false,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Raumname"),
              onChanged: (text) {
                setState(() {
                  chosenRoom = null;
                });
              },
            ),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              _showColorAlertDialog(context);
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: currentColor,
              ),
            ),
          ),
        ],
      ),
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
                  "Farbe",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Wahl",
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
            _roomsForDisplay = _uniqueRooms.where((room) {
              var roomName = room.roomname.toLowerCase();
              return roomName.contains(text);
            }).toList();
          });
          _sortRoomsForDisplay();
        },
      ),
    );
  }

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
                chosenRoom == _roomsForDisplay[index]
                    ? chosenRoom = null
                    : chosenRoom = _roomsForDisplay[index];
              });
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _roomsForDisplay[index].roomname,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color:
                            Color(int.parse(_roomsForDisplay[index].roomcolor)),
                      ),
                    ),
                    Checkbox(
                        activeColor: buttonColor,
                        value: chosenRoom == _roomsForDisplay[index],
                        onChanged: (bool value) {}),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _bottomButtons() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            child: Text(
              "Abbrechen",
              style: TextStyle(
                color: buttonColor,
                fontSize: 18,
              ),
            ),
            onPressed: () =>
                {Navigator.pushReplacementNamed(context, "/deviceOverview")},
          ),
          FlatButton(
            child: Text(
              "Bestätigen",
              style: TextStyle(
                color: buttonColor,
                fontSize: 18,
              ),
            ),
            onPressed: () =>
                {Navigator.pushReplacementNamed(context, "/deviceOverview")},
          ),
        ],
      ),
    );
  }

  // Gives the colorPicker AlertDialog with the colors above
  _showColorAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
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
              contentPadding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              content: Container(
                width: 300,
                height: 470,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Card(
                        elevation: 0,
                        child: ColorPicker(
                          color: currentColor,
                          onColorChanged: (Color color) =>
                              setState(() => currentColor = color),
                          width: 50,
                          height: 50,
                          elevation: 0,
                          borderRadius: 4,
                          padding: EdgeInsets.fromLTRB(6, 10, 6, 0),
                          heading: Text(
                            "selectColor".tr().toString(),
                            style: TextStyle(
                              fontSize: 22,
                              color: darkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          subheading: Text(
                            "selectShade".tr().toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: darkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          pickersEnabled: const <ColorPickerType, bool>{
                            ColorPickerType.primary: true,
                            ColorPickerType.accent: false,
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: FlatButton(
                            child: Text(
                              "Ok",
                              style: TextStyle(
                                color: buttonColor,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
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
  }

  _sortRoomsForDisplay() {
    setState(() {
      if (_sortAscending) {
        _roomsForDisplay.sort((a, b) => a.roomname.compareTo(b.roomname));
      } else {
        _roomsForDisplay.sort((a, b) => b.roomname.compareTo(a.roomname));
      }
    });
  }
}
