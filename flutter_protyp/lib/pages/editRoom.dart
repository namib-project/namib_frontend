import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:flutter_protyp/pages/roomDetailsBuilder.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class EditRoomTable extends StatefulWidget {
  const EditRoomTable({
    Key key,
    @required this.rooms,
  }) : super(key: key);

  /// List which stores all given rooms
  final List<Room> rooms;

  _EditRoomTableState createState() => _EditRoomTableState();
}

/// Class for creating and choosing a room for editing
class _EditRoomTableState extends State<EditRoomTable> {
  /// Displayed rooms list
  List<Room> _roomsForDisplay;

  /// Variables for creating room and visibility of error message
  String _newRoomName;
  bool roomNameMessage = false;

  /// to get the value to create a room with color use: currentColor.value.toString()
  Color _newColor = Color(0xFFB00020);

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

  @override
  void initState() {
    super.initState();
    _roomsForDisplay = widget.rooms;
    _sortRoomsForDisplay();
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
                    'roomChoice'.tr().toString(),
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(160, 60)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0))),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/deviceOverview");
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
                Visibility(
                  visible: adminAccess,
                  child: Container(
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
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 16,
                      child: (_roomsForDisplay != null &&
                              _roomsForDisplay.length != 0)
                          ? Column(
                              children: <Widget>[
                                _searchBar(),
                                _listHeader(),
                                Container(
                                  height: 250,
                                  child: _listForRooms(context),
                                ),
                                Visibility(
                                    visible: adminAccess,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          alignment: Alignment.center,
                                          child: SelectableText(
                                            'orCreateNew'.tr().toString(),
                                            style: TextStyle(
                                              fontFamily: "OpenSans",
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        _newRoomDialog(),
                                        Visibility(
                                          visible: roomNameMessage,
                                          child: Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            child: SelectableText(
                                              "wrongRoomName".tr().toString(),
                                              style: TextStyle(
                                                  color: Colors.red[700],
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        _bottomButtons(),
                                      ],
                                    ))
                              ],
                            )
                          : Container(
                              height: 300,
                              child: Column(children: [
                                Card(
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
                                Visibility(
                                    visible: adminAccess,
                                    child: Column(children: [
                                      Container(
                                        height: 70,
                                        alignment: Alignment.center,
                                        child: SelectableText(
                                          'orCreateNew'.tr().toString(),
                                          style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      _newRoomDialog(),
                                      Visibility(
                                        visible: roomNameMessage,
                                        child: Container(
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: SelectableText(
                                            "wrongRoomName".tr().toString(),
                                            style: TextStyle(
                                                color: Colors.red[700],
                                                fontSize: 50),
                                          ),
                                        ),
                                      ),
                                      _bottomButtons(),
                                    ])),
                                SizedBox(
                                  height: 10,
                                ),
                              ])),
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

  /// Input fields for room name and room color
  _newRoomDialog() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 280,
            child: TextField(
              maxLength: 50,
              obscureText: false,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'roomName'.tr().toString(),
              ),
              onChanged: (text) {
                setState(() {
                  _newRoomName = text;
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
                color: _newColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Header for room list
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Searchbar for searching through room list
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
            _roomsForDisplay = _roomsForDisplay.where((room) {
              var roomName = room.name.toLowerCase();
              return roomName.contains(text);
            }).toList();
          });
          _sortRoomsForDisplay();
        },
      ),
    );
  }

  /// List entries for room list
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
            onTap: adminAccess
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomDetails(
                          roomId: _roomsForDisplay[index].id,
                        ),
                      ),
                    );
                  }
                : null,
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
                          mainAxisAlignment: MainAxisAlignment.end,
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
                          ]),
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

  /// Button for creating a new room
  _bottomButtons() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
              child: Text(
                'create'.tr().toString(),
                style: TextStyle(
                  color: buttonColor,
                  fontSize: 18,
                ),
              ),
              onPressed: _postRoomButton()
                  ? () {
                      _postRoom();
                    }
                  : null),
        ],
      ),
    );
  }

  /// Function that determines if create room button is clickable
  bool _postRoomButton() {
    if (_newRoomName != null && _newRoomName != "") {
      return true;
    }
    return false;
  }

  /// Function that post a new room to controller
  _postRoom() async {
    String _postRoomExtension = "rooms";

    var _response;

    if (_newRoomName != null && _newRoomName != "") {
      Map<String, dynamic> data = {
        "color": _newColor.value.toString(),
        "name": _newRoomName
      };

      _response = await http
          .post(
            Uri.parse(url + _postRoomExtension),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $jwtToken"
            },
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 5));
    }
    checkResponse(_response.statusCode);
  }

  /// Function that gets the status code of the post request from _postRoom() and shows error message on error
  void checkResponse(int statusCode) {
    if (statusCode == 409) {
      setState(() {
        roomNameMessage = true;
      });
    } else if (statusCode == 200) {
      Navigator.pushReplacementNamed(context, "/editRoom");
      roomNameMessage = false;
    }
  }

  /// Gives the colorPicker AlertDialog with the colors above
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
                          color: _newColor,
                          onColorChanged: (Color color) =>
                              setState(() => _newColor = color),
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
                          child: TextButton(
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

  /// Sorts the rooms list
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
