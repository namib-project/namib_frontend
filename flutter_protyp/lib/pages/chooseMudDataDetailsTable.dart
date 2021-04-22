import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/mudData.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChooseMudDataDetailsTable extends StatefulWidget {
  const ChooseMudDataDetailsTable({
    Key key,
    @required this.mudData,
  }) : super(key: key);

  final MUDData mudData;

  @override
  _ChooseMudDataDetailsTableState createState() =>
      _ChooseMudDataDetailsTableState();
}

class _ChooseMudDataDetailsTableState extends State<ChooseMudDataDetailsTable> {
  bool inRegion = false;

  bool editColumn = false;
  bool resetButton = false;

  List<String> _aclListForDisplay = [];
  List<String> _aclListCopy = [];

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
    _generateDnsList();
    _aclListForDisplay = List.from(_aclListCopy);
    _sortAclListForDisplay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                SelectableText(
                  widget.mudData.systeminfo == null
                      ? ""
                      : widget.mudData.systeminfo,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SelectableText(
                  widget.mudData.url,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                // Column(
                //   children: mobileDevice ? _mobileView() : _desktopView(),
                // ),

                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 40,
                ),
                // Table row to display and edit the different DNS-Requests
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SelectableText(
                            'allowedDNSRequests'.tr().toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                    _expertModeText(context),
                  ],
                ),
                // This table displays the HTTP-addresses which are allowed
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 16,
                      child: (widget.mudData.acllist != null &&
                              widget.mudData.acllist.length != 0)
                          ? Column(
                              children: <Widget>[
                                _searchBar(),
                                _listHeader(),
                                Container(
                                  height: 500,
                                  child: _listForAcl(),
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
    _aclListCopy = [];
    if (widget.mudData.acl_override.isEmpty) {
      widget.mudData.acllist.forEach(
        (aclElement) {
          aclElement.ace.forEach(
            (aceElement) {
              if (aceElement.matches.dnsname != null) {
                _aclListCopy.add(aceElement.matches.dnsname);
              }
            },
          );
        },
      );
    } else {
      widget.mudData.acl_override.forEach(
        (aclElement) {
          aclElement.ace.forEach(
            (aceElement) {
              if (aceElement.matches.dnsname != null) {
                _aclListCopy.add(aceElement.matches.dnsname);
              }
            },
          );
        },
      );
    }
    _aclListCopy = _aclListCopy.toSet().toList();
    _aclListForDisplay = List.from(_aclListCopy);
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
                          content: Text("explanationDNSNames".tr().toString()),
                          actions: [
                            TextButton(
                              child: Text(
                                "Ok!",
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(); // dismiss dialog
                              },
                            )
                          ],
                        );
                      },
                    );
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

  //Function that shows the overlay element
  showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    overlayState.insert(overlayEntry);
  }

  //Function for closing the overlay element
  closeOverlay() {
    overlayEntry.remove();
  }

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
    ),
  );

  List<Widget> _desktopView() {
    var column1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[],
    );

    var column2 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     SelectableText(
        //       'documentation'.tr().toString() + ": ",
        //       style: TextStyle(fontSize: 20),
        //     ),
        //     SelectableText(
        //       widget.mudData.documentation,
        //       style: TextStyle(fontSize: 18),
        //       onTap: () {
        //         // _launchDocumentation();
        //       },
        //     ),
        //   ],
        // )
      ],
    );

    var row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        column1,
        SizedBox(
          width: 200,
        ),
        column2
      ],
    );

    List<Widget> list = [
      SizedBox(
        height: 40,
      ),
      row,
      SizedBox(
        height: 30,
      )
    ];
    return list;
  }

  List<Widget> _mobileView() {
    var selectableText1 = SelectableText(
      "ipaddress".tr().toString(),
      style: TextStyle(fontSize: 20),
    );

    var sizedBox1 = SizedBox(
      height: 20,
    );
    var selectableText3 = SelectableText(
      "lastinteraction".tr().toString(),
      style: TextStyle(fontSize: 20),
    );

    var sizedBox2 = SizedBox(
      height: 20,
    );
    var selectableText5 = SelectableText(
      "MUD URL: ",
      style: TextStyle(fontSize: 20),
    );

    var sizedBox3 = SizedBox(
      height: 20,
    );
    var selectableText7 = SelectableText(
      'documentation'.tr().toString(),
      style: TextStyle(fontSize: 20),
    );

    List<Widget> list = [
      selectableText1,
      sizedBox1,
      selectableText3,
      sizedBox2,
      selectableText5,
      sizedBox3,
      selectableText7,
    ];

    return list;
  }
}
