import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/enforcer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/pages/formatter/timeFormatter.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class EnforcerOverview extends StatefulWidget {
  EnforcerOverview({
    Key key,
    @required this.enforcers,
  }) : super(key: key);

  /// List which stores all given devices
  final List<Enforcer> enforcers;

  _EnforcerOverviewState createState() => _EnforcerOverviewState();
}

//Class for user registration, will only be used at the first usage
class _EnforcerOverviewState extends State<EnforcerOverview> {
  List<Enforcer> _enforcersForDisplay;
  bool _sortAscending = true;
  Icon _arrowUp = Icon(
    FontAwesomeIcons.arrowUp,
    size: 17,
  );
  Icon _arrowDown = Icon(
    FontAwesomeIcons.arrowDown,
    size: 17,
  );

  TimeFormatter formatter = new TimeFormatter();

  @override
  void initState() {
    super.initState();
    _enforcersForDisplay = widget.enforcers;
    _enforcersForDisplay.forEach((element) {
      element.last_interaction =
          formatter.formatTimeAgo(element.last_interaction);
    });
    _sortEnforcersForDisplay();
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
                TextButton.icon(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(160, 60)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0))),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/enforcerBuilder");
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  child: SelectableText(
                    'Enforcer',
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
                    'enforcerList'.tr().toString(),
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
                      child: (widget.enforcers != null &&
                              widget.enforcers.length != 0)
                          ? Column(
                              children: <Widget>[
                                _searchBar(),
                                _listHeader(),
                                Container(
                                  height: 500,
                                  child: _listForDevices(context),
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
                    )
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
          _sortEnforcersForDisplay();
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
                          'certId'.tr().toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "allowed".tr().toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "lastinteraction".tr().toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "lastIP".tr().toString(),
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                )
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
            _enforcersForDisplay = widget.enforcers.where((enforcer) {
              var deviceName = enforcer.cert_id.toLowerCase();
              return deviceName.contains(text);
            }).toList();
          });
          _sortEnforcersForDisplay();
        },
      ),
    );
  }

  _updateEnforcer(Enforcer enforcer, bool allowedValue) async {
    String _enforcersExtension =
        "enforcers/${enforcer.cert_id}?allowed=${enforcer.allowed}";

    http.put(url + _enforcersExtension, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    });
  }

  ListView _listForDevices(BuildContext context) {
    return ListView.builder(
      itemCount: _enforcersForDisplay.length,
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {
              showEnforcerDetailDialog(context);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _enforcersForDisplay[index].cert_id,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Checkbox(
                        value: _enforcersForDisplay[index].allowed,
                        onChanged: adminAccess
                            ? (value) {
                                setState(() {
                                  _enforcersForDisplay[index].allowed = value;
                                });
                                _updateEnforcer(
                                    _enforcersForDisplay[index], value);
                              }
                            : null),
                    Text(
                      _enforcersForDisplay[index].last_interaction,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      _enforcersForDisplay[index].last_ip_address,
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

  _sortEnforcersForDisplay() {
    setState(() {
      if (_sortAscending) {
        _enforcersForDisplay.sort((a, b) => a.cert_id.compareTo(b.cert_id));
      } else {
        _enforcersForDisplay.sort((a, b) => b.cert_id.compareTo(a.cert_id));
      }
    });
  }

  showEnforcerDetailDialog(BuildContext context) {}
}
