import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/chooseMudDataDetailsBuilder.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_protyp/data/device_mud/mudGuess.dart';
import 'chooseClipArt.dart';
import 'chooseRoomBuilder.dart';

/// This class builds the page where MUD-Profiles must be given to a device and other properties can be given

class ChooseMudDataTable extends StatefulWidget {
  ChooseMudDataTable({
    Key key,
    @required this.mudGuessList,
    @required this.device,
  }) : super(key: key);

  /// List with MUD-Guesses
  final List<MudGuess> mudGuessList;

  /// A new device
  final Device device;

  _ChooseMudDataTableState createState() => _ChooseMudDataTableState();
}

class _ChooseMudDataTableState extends State<ChooseMudDataTable> {
  /// List which displays MUD-Entries
  List<MudGuess> _mudGuessListForDisplay;
 /// A new device
  Device _newDevice;
 /// MUD-Guess-Entry
  MudGuess _chosenMudGuess;
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

  /// Name of the device
  String _name = "";

  /// Takes the name of the device and stores
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _mudGuessListForDisplay = widget.mudGuessList;
    _sortMudGuessListForDisplay();
    _newDevice = widget.device;

    textEditingController.text = _newDevice.name != null ? _newDevice.name : "";
    if (_newDevice.mud_url != null) {
      widget.mudGuessList.forEach((element) {
        if (element.mud_url == _newDevice.mud_url) {
          _chosenMudGuess = element;
        }
      });
    }
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
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  child: SelectableText(
                    'deviceCreation'.tr().toString(),
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
                    'chooseFittingProfile'.tr().toString(),
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
                      child: (widget.mudGuessList != null &&
                              widget.mudGuessList.length != 0)
                          ? Column(
                              children: <Widget>[
                                _searchBar(),
                                _listHeader(),
                                Container(
                                  height: 250,
                                  child: _listForMudData(context),
                                ),
                                Container(
                                  height: 70,
                                  alignment: Alignment.center,
                                  child: SelectableText(
                                    'chooseDeviceName'.tr().toString(),
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 70,
                                  width: 400,
                                  alignment: Alignment.center,
                                  child: TextField(
                                    obscureText: false,
                                    controller: textEditingController,
                                    cursorColor: Colors.grey,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'name'.tr().toString(),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _name = value;
                                        _newDevice.name = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: 400,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(120, 50)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            buttonColor,
                                          ),
                                        ),
                                        child: Text(
                                          "Raum auswählen",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChooseRoom(
                                                        device: _newDevice,
                                                        mudGuesses: widget
                                                            .mudGuessList),
                                              ));
                                        },
                                      ),
                                      Visibility(
                                        visible: _newDevice.room != null,
                                        child: Container(
                                          width: 200,
                                          height: 70,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      _newDevice.room != null
                                                          ? _newDevice.room.name
                                                          : "",
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
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            color: Color(
                                                              int.parse(_newDevice
                                                                          .room !=
                                                                      null
                                                                  ? _newDevice
                                                                      .room
                                                                      .color
                                                                  : "0xFFB00020"),
                                                            ),
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
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 400,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(120, 50)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            buttonColor,
                                          ),
                                        ),
                                        child: Text(
                                          "Clipart auswählen",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChooseClipart(
                                                      device: _newDevice,
                                                      mudGuesses:
                                                          widget.mudGuessList),
                                            ),
                                          );
                                        },
                                      ),
                                      Visibility(
                                        visible: _newDevice.clipart != null,
                                        child: Container(
                                          height: 60,
                                          width: 200,
                                          child: SvgPicture.asset(
                                            _newDevice.clipart != null
                                                ? _newDevice.clipart
                                                : allClipArts[0],
                                            color: _newDevice.room != null
                                                ? Color(int.parse(
                                                    _newDevice.room.color))
                                                : (darkMode
                                                    ? Colors.grey[500]
                                                    : Colors.black),
                                            height: 60,
                                            width: 60,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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

  /// Build actionbuttons and display it
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
            onPressed: () =>
                {Navigator.pushReplacementNamed(context, "/deviceOverview")},
          ),
          TextButton(
              child: Text(
                'confirm'.tr().toString(),
                style: TextStyle(
                  color: buttonColor,
                  fontSize: 18,
                ),
              ),
              onPressed: _newDevice.mud_url != null
                  ? () {
                      _putDevice();
                    }
                  : null),
        ],
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
          _sortMudGuessListForDisplay();
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
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
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'manufacturer'.tr().toString(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'details'.tr().toString(),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'select'.tr().toString(),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
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
            _mudGuessListForDisplay = widget.mudGuessList.where((mudGuess) {
              var mudGuessName = mudGuess.model_name.toLowerCase();
              var mudGuessManName = mudGuess.manufacturer_name.toLowerCase();

              return (mudGuessName.contains(text) ||
                  mudGuessManName.contains(text));

              // return mudGuessName.contains(text);
            }).toList();
          });
          _sortMudGuessListForDisplay();
        },
      ),
    );
  }

  /// This functions is for display the table
  ListView _listForMudData(BuildContext context) {
    return ListView.builder(
      itemCount: _mudGuessListForDisplay.length,
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {
              setState(() {
                _chosenMudGuess == _mudGuessListForDisplay[index]
                    ? _chosenMudGuess = null
                    : _chosenMudGuess = _mudGuessListForDisplay[index];
                if (_chosenMudGuess != null) {
                  _newDevice.mud_url = _chosenMudGuess.mud_url;
                }
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
                      flex: 3,
                      child: Text(
                        _mudGuessListForDisplay[index].model_name == null
                            ? ""
                            : _mudGuessListForDisplay[index].model_name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        _mudGuessListForDisplay[index].manufacturer_name == null
                            ? ""
                            : _mudGuessListForDisplay[index].manufacturer_name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.search,
                            size: 17,
                          ),
                          onPressed: () {
                            return Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChooseMudDataDetails(
                                  mudGuessUrl:
                                      _mudGuessListForDisplay[index].mud_url,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Checkbox(
                          activeColor: buttonColor,
                          value:
                              _chosenMudGuess == _mudGuessListForDisplay[index],
                          onChanged: (bool value) {
                            setState(() {
                              _chosenMudGuess == _mudGuessListForDisplay[index]
                                  ? _chosenMudGuess = null
                                  : _chosenMudGuess =
                                      _mudGuessListForDisplay[index];
                              if (_chosenMudGuess != null) {
                                _newDevice.mud_url = _chosenMudGuess.mud_url;
                              }
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

  /// Sort function for MUD-Guesses-List
  _sortMudGuessListForDisplay() {
    setState(() {
      if (_sortAscending) {
        _mudGuessListForDisplay
            .sort((a, b) => a.model_name.compareTo(b.model_name));
      } else {
        _mudGuessListForDisplay
            .sort((a, b) => b.model_name.compareTo(a.model_name));
      }
    });
  }

  /// Function sends the edited device to server
  _putDevice() async {
    String _deviceId = widget.device.id.toString();
    String _deviceExtension = "devices/$_deviceId";

    Map<String, dynamic> _data = {
      "clipart": widget.device.clipart != null
          ? widget.device.clipart
          : allClipArts[0],
      "mud_url": _newDevice.mud_url,
      "room_id": widget.device.room != null ? widget.device.room.id : null,
      "name": _newDevice.name != null ? _newDevice.name : ""
    };

    await http.put(url + _deviceExtension, body: jsonEncode(_data), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    });

    Navigator.pushReplacementNamed(context, "/deviceOverview");
  }
}
