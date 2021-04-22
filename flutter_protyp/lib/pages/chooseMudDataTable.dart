import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/chooseMudDataDetails.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_protyp/data/device_mud/mudGuess.dart';

import 'chooseClipArt.dart';
import 'chooseRoom.dart';

class ChooseMudDataTable extends StatefulWidget {
  ChooseMudDataTable({
    Key key,
    @required this.mudGuessList,
    @required this.device,
  }) : super(key: key);

  final List<MudGuess> mudGuessList;
  final Device device;

  _ChooseMudDataTableState createState() => _ChooseMudDataTableState();
}

//Class for user registration, will only be used at the first usage
class _ChooseMudDataTableState extends State<ChooseMudDataTable> {
  List<MudGuess> _mudGuessListForDisplay;

  Device _newDevice;

  MudGuess _chosenMudGuess;
  bool _sortAscending = true;
  Icon _arrowUp = Icon(
    FontAwesomeIcons.arrowUp,
    size: 17,
  );
  Icon _arrowDown = Icon(
    FontAwesomeIcons.arrowDown,
    size: 17,
  );

  String _name = "";

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
                                  width: 350,
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
                                ElevatedButton(
                                  child: Text("Raum auswählen"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChooseRoom(
                                              device: _newDevice,
                                              mudGuesses: widget.mudGuessList),
                                        ));
                                  },
                                ),
                                ElevatedButton(
                                  child: Text("Clipart auswählen"),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChooseClipart(
                                              device: _newDevice,
                                              mudGuesses: widget.mudGuessList),
                                        ));
                                  },
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
