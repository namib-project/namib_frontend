import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/data/device_mud/mudData.dart';
import 'package:flutter_protyp/pages/chooseMudData.dart';
import 'package:flutter_protyp/pages/chooseMudDataDetails.dart';
import 'package:flutter_protyp/pages/deviceDetails.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'chooseRoom.dart';

class ChooseMudDataTable extends StatefulWidget {
  ChooseMudDataTable({
    Key key,
    @required this.mudDataList,
  }) : super(key: key);

  final List<MUDData> mudDataList;

  _ChooseMudDataTableState createState() => _ChooseMudDataTableState();
}

//Class for user registration, will only be used at the first usage
class _ChooseMudDataTableState extends State<ChooseMudDataTable> {
  List<MUDData> _mudDataListForDisplay;

  var txt = TextEditingController();

  MUDData _chosenMudData;
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
      _mudDataListForDisplay = widget.mudDataList;
      _sortMudDataListForDisplay();
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
                      child: (widget.mudDataList != null &&
                              widget.mudDataList.length != 0)
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
                  builder: (context) => ChooseRoom(),
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
          _sortMudDataListForDisplay();
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
            _mudDataListForDisplay = widget.mudDataList.where((mudData) {
              var mudDataName = mudData.systeminfo.toLowerCase();
              return mudDataName.contains(text);
            }).toList();
          });
          _sortMudDataListForDisplay();
        },
      ),
    );
  }

  ListView _listForMudData(BuildContext context) {
    return ListView.builder(
      itemCount: _mudDataListForDisplay.length,
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _mudDataListForDisplay[index].systeminfo,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseMudDataDetails(
                                mudData: _mudDataListForDisplay[index]),
                          ),
                        );
                      },
                    ),
                    Checkbox(
                      activeColor: buttonColor,
                      value: _chosenMudData == _mudDataListForDisplay[index],
                      onChanged: (bool value) {
                        setState(() {
                          _chosenMudData == _mudDataListForDisplay[index]
                              ? _chosenMudData = null
                              : _chosenMudData = _mudDataListForDisplay[index];
                          txt.text = _mudDataListForDisplay[index].systeminfo;
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

  _sortMudDataListForDisplay() {
    setState(() {
      if (_sortAscending) {
        _mudDataListForDisplay
            .sort((a, b) => a.systeminfo.compareTo(b.systeminfo));
      } else {
        _mudDataListForDisplay
            .sort((a, b) => b.systeminfo.compareTo(a.systeminfo));
      }
    });
  }
}
