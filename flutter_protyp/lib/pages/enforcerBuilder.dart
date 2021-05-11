import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/enforcer.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

import 'enforcerOverview.dart';

/// Class that implements Future Builder for the enforcer list which means gets data
class EnforcerBuilder extends StatefulWidget {
  _EnforcerBuilderState createState() => _EnforcerBuilderState();
}

class _EnforcerBuilderState extends State<EnforcerBuilder> {
  /// A List to safe all devices
  Future<List<Enforcer>> enforcers;

  @override
  void initState() {
    super.initState();
    enforcers = getEnforcers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppbar(),
        drawer: MainDrawer(),
        body: Center(
            child: Column(children: [
          /// Future Builder for expecting enforcer list
          FutureBuilder<List<Enforcer>>(
            future: enforcers,
            builder: (context, snapshotDevice) {
              if (snapshotDevice.hasData) {
                return Expanded(
                    child: EnforcerOverview(enforcers: snapshotDevice.data));
              } else if (snapshotDevice.hasError) {
                /// If the process failed this message returns
                print(snapshotDevice.error);
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
                                  context, "/enforcerBuilder");
                            })
                      ]),
                );
              }
              /// By default, show a loading spinner.
              else {
                return SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ])));
  }

  /// Function getting the list of enforcers in network from controller
  Future<List<Enforcer>> getEnforcers() async {
    String devicesExtension = 'enforcers';
    var _response = await http.get(url + devicesExtension, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      return null;
    });

    if (_response.statusCode == 200) {
      var jsonEnforcers = jsonDecode(_response.body) as List;
      List<Enforcer> enforcers =
          jsonEnforcers.map((tagJson) => Enforcer.fromJson(tagJson)).toList();
      return enforcers;
    } else {
      throw Exception("Failed to get Data");
    }
  }
}
