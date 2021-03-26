import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/data/device_mud/mudData.dart';
import 'package:flutter_protyp/pages/chooseMudData.dart';
import 'package:flutter_protyp/pages/chooseMudDataDetails.dart';
import 'package:flutter_protyp/pages/deviceDetails.dart';
import 'package:flutter_protyp/data/device_mud/mudData.dart';
import 'dart:convert';

import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_protyp/data/device_mud/mudGuess.dart';

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

  MUDData _mudData;

  var txt = TextEditingController();

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

  @override
  void initState() {
    setState(() {
      _mudGuessListForDisplay = widget.mudGuessList;
      _sortMudGuessListForDisplay();
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
                    'Geräteerstellung'.tr().toString(),
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
                    "Wählen Sie ein passendes Profil",
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
                                    "Und Wählen Sie einen Gerätenamen",
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
                                    controller: txt,
                                    obscureText: false,
                                    cursorColor: Colors.grey,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Gerätename"),
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
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChooseRoom(
                    device: widget.device,
                  ),
                ),
              )
            },
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
          _sortMudGuessListForDisplay();
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
                  "Hersteller",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Details",
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
                txt.text = _mudGuessListForDisplay[index].model_name;
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
                      _mudGuessListForDisplay[index].model_name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      _mudGuessListForDisplay[index].manufacturer_name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.search,
                        size: 17,
                      ),
                      onPressed: () {
                        /// TODO: redirect to detailSite with real MudData

                        _mudData = getMudData();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChooseMudDataDetails(mudData: _mudData),
                          ),
                        );

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ChooseMudDataDetails(
                        //         mudData: _mudGuessListForDisplay[index]),
                        //   ),
                        // );
                      },
                    ),
                    Checkbox(
                      activeColor: buttonColor,
                      value: _chosenMudGuess == _mudGuessListForDisplay[index],
                      onChanged: (bool value) {
                        ///
                        setState(() {
                          _chosenMudGuess == _mudGuessListForDisplay[index]
                              ? _chosenMudGuess = null
                              : _chosenMudGuess =
                                  _mudGuessListForDisplay[index];
                          txt.text = _mudGuessListForDisplay[index].model_name;
                        });
                      },
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

  /// TODO: decode not as list but as one object !
  MUDData getMudData() {
    // String devicesExtension = 'devices';
    // response = await http.get(url + devicesExtension, headers: {
    //   "Content-Type": "application/json",
    //   "Authorization": "Bearer $jwtToken"
    // }).timeout(const Duration(seconds: 5), onTimeout: () {
    //   return _handleTimeOut();
    // });

    /// In reality this is not a List !!
    String test =
        '[{"acl_override": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"acllist": [{"ace": [{"action": "Accept","matches": {"address_mask": "string","destination_port": {"range": [0],"single": 0},"direction_initiated": "FromDevice","dnsname": "string","protocol": {"name": "TCP","num": 0},"source_port": {"range": [0],"single": 0}},"name": "string"}],"acl_type": "IPV6","name": "string","packet_direction": "FromDevice"}],"documentation": "string","expiration": "2021-03-26T20:51:27.099Z","last_update": "string","masa_url": "string","mfg_name": "string","model_name": "string","systeminfo": "string","url": "string"}]';

    //print("Response code: " + response.statusCode.toString());
    //print(response.body);

    //if (response.statusCode == 200) {

    var jsonMudData = jsonDecode(test) as List;
    List<MUDData> mudDataTest =
        jsonMudData.map((tagJson) => MUDData.fromJson(tagJson)).toList();

    //jsonMudData.map((tagJson) => MudData.fromJson(tagJson)).toList();

    return mudDataTest[0];

    //} else {
    //throw Exception("Failed to get Data");
    //}
    //TODO bei release auf http request umstellen
  }
}
