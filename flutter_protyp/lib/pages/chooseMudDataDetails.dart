import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/mudData.dart';
import 'package:flutter_protyp/pages/chooseMudDataDetailsTable.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_encoder/url_encoder.dart';
import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';

class ChooseMudDataDetails extends StatefulWidget {
  const ChooseMudDataDetails({
    Key key,
    @required this.mudGuessUrl,
  }) : super(key: key);
  final String mudGuessUrl;

  _ChooseMudDataDetailsState createState() => _ChooseMudDataDetailsState();
}

class _ChooseMudDataDetailsState extends State<ChooseMudDataDetails> {
  List<String> _aclListForDisplay = [];
  List<String> _aclListCopy = [];

  Future<List<MUDData>> _mudDataFuture;
  MUDData _mudData;

  var response;

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
    _mudDataFuture = _getMudDataFuture();
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
        child: FutureBuilder<List<MUDData>>(
            future: _mudDataFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ChooseMudDataDetailsTable(
                  mudData: snapshot.data[0],
                );
              } else if (snapshot.hasError) {
                // If the process failed this message returns
                print(snapshot.error);
                return Container(
                  width: 600,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SelectableText("wentWrongError".tr().toString()),
                        ElevatedButton(
                            child: Text("reload".tr().toString()),
                            onPressed: () {
                              Navigator.pushReplacementNamed(

                                  /// TODO: mit daten die seite neu laden
                                  context,
                                  "/chooseMudDataDetails");
                            })
                      ]),
                );
              }
              // By default, show a loading spinner.
              else {
                return SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                );
              }
            }),
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
          _sortAclListForDisplay();
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
                          'address'.tr().toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
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
            _aclListForDisplay = _aclListCopy.where((aceElement) {
              var aceName = aceElement.toLowerCase();
              return aceName.contains(text);
            }).toList();
          });
          _sortAclListForDisplay();
        },
      ),
    );
  }

  ListView _listForAcl() {
    return ListView.builder(
      itemCount: _aclListForDisplay.length,
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {},
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _aclListForDisplay[index],
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
      },
    );
  }

  _generateDnsList() {
    _mudData.acllist.forEach((aclElement) {
      aclElement.ace.forEach((aceElement) {
        if (aceElement.matches.dnsname != null)
          _aclListCopy.add(aceElement.matches.dnsname);
      });
    });
  }

  _sortAclListForDisplay() {
    setState(() {
      if (_sortAscending) {
        _aclListForDisplay.sort((a, b) => a.compareTo(b));
      } else {
        _aclListForDisplay.sort((a, b) => b.compareTo(a));
      }
    });
  }

  Visibility _expertModeText(BuildContext context) {
    return Visibility(
      visible: !expertMode,
      child:
          mobileDevice //if mobile device, then icon button with dialog, else icon with hover effect
              ? IconButton(
                  icon: Icon(Icons.help_center),
                  iconSize: 30,
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("explanation".tr().toString()),
                            content:
                                Text("explanationDNSNames".tr().toString()),
                            actions: [
                              FlatButton(
                                child: Text("Ok!"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // dismiss dialog
                                },
                              )
                            ],
                          );
                        });
                  },
                )
              : MouseRegion(
                  //MouseRegion for the hover element
                  onEnter: _enterInRegion,
                  onExit: _exitInRegion,
                  child: Icon(Icons.help_center),
                ),
    );
  }

  ///True if mouse is in the MouseRegion widget, else false
  bool inRegion = false;

  //Creating the overlay element just an example for expert mode
  OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Center(
            child: Container(
              width: 400,
              height: 200,
              padding: EdgeInsets.all(20),
              alignment: Alignment(0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: darkMode
                    ? Colors.black.withOpacity(0.9)
                    : Colors.grey.withOpacity(0.9),
              ),
              child: Column(
                children: [
                  SelectableText(
                    "explanation".tr().toString(),
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 35,
                        color: darkMode ? Colors.white : Colors.black,
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SelectableText(
                    "explanationDNSNames".tr().toString(),
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20,
                        color: darkMode ? Colors.white : Colors.black,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
            ),
          ));

  //Function that shows the overlay element
  showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    overlayState.insert(overlayEntry);
  }

  //Function for closing the overlay element

  closeOverlay() {
    overlayEntry.remove();
  }

  //Function called from MouseRegion widget below, opens the overlay on mouse enter
  void _enterInRegion(PointerEvent details) {
    setState(() {
      inRegion = true;
    });
    showOverlay(context);
  }

  //Function called from MouseRegion widget below, closes the overlay on mouse exit
  void _exitInRegion(PointerEvent details) {
    setState(() {
      inRegion = false;
    });
    closeOverlay();
  }


  Future<List<MUDData>> _getMudDataFuture() async {
    String _mudDataExtension = 'mud/';

    String _urlExtension = "?mud_url=";
    String _urlEncodedMudUrl = urlEncode(text: widget.mudGuessUrl).toString();

    response = await http.get(
        url + _mudDataExtension + _urlExtension + _urlEncodedMudUrl,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        }).timeout(const Duration(seconds: 5), onTimeout: () {
      return _handleTimeOut();
    });


    if (response.statusCode == 200) {
      var jsonMudData = jsonDecode(response.body) as List;
      List<MUDData> mudDataTest =
          jsonMudData.map((e) => MUDData.fromJson(e)).toList();
      return mudDataTest;
    } else {
      throw Exception("Failed to get Data");
    }
  }

  dynamic _handleTimeOut() {}
}
