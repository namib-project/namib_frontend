import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device_mud/mudGuess.dart';
import 'package:flutter_protyp/pages/chooseMudDataTable.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class ChooseMudData extends StatefulWidget {
  ChooseMudData({
    Key key,
    @required this.device,
  }) : super(key: key);

  final Device device;

  _ChooseMudDataState createState() => _ChooseMudDataState();
}

class _ChooseMudDataState extends State<ChooseMudData> {
  Future<List<MudGuess>> mudGuessList;

  /// URL response to store
  var response;

  @override
  void initState() {
    super.initState();

    mudGuessList = getMudGuessList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SelectableText(
          'details'.tr().toString(),
        ),
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
        child: Column(
          children: [
            // This future builder element put in the different devices after these will be loaded
            // The future builder element a delayed sending of context

            FutureBuilder<List<MudGuess>>(
              future: mudGuessList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: ChooseMudDataTable(
                    mudGuessList: snapshot.data,
                    device: widget.device,
                  ));
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
                                    context, "/chooseRoom");
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
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<MudGuess>> getMudGuessList() async {
    ///  String id = widget.device.id.toString();
    ///  String mudGuessExtension = 'devices/$id/guesses';
    ///
    ///  print("kleiner test1");
    ///  print(url + mudGuessExtension);
    ///
    ///  response = await http.get(url + mudGuessExtension, headers: {
    ///    "Content-Type": "application/json",
    ///    "Authorization": "Bearer $jwtToken"
    ///  }).timeout(const Duration(seconds: 5), onTimeout: () {
    ///    return _handleTimeOut();
    ///  });
    ///
    ///  print("kleiner test");
    ///  print(url + mudGuessExtension);
    ///  print(response.statusCode);
    ///  if (response.statusCode == 200) {
    ///    var jsonMudGuessData = jsonDecode(response.body) as List;
    ///    List<MudGuess> mudTest = jsonMudGuessData
    ///        .map((tagJson) => MudGuess.fromJson(tagJson))
    ///        .toList();
    ///    return mudTest;
    ///  } else {
    ///    throw Exception("Failed to get Data");
    ///  }
    ///}
    ///
    ///
    ///
    ///
    ///

    String test =
        '[{"manufacturer_name": null,"model_name": "AmazonEcho","mud_url": "https://iotanalytics.unsw.edu.au/mud/amazonEchoMud.json"},'
        '{"manufacturer_name": "dorbellUnternehmen","model_name": null,"mud_url": "https://iotanalytics.unsw.edu.au/mud/augustdoorbellcamMud.json"}]';
    //print("Response code: " + response.statusCode.toString());
    //print(response.body);

    //if (response.statusCode == 200) {
    var jsonMudGuesses = jsonDecode(test) as List;
    List<MudGuess> mudGuessesTest =
        jsonMudGuesses.map((tagJson) => MudGuess.fromJson(tagJson)).toList();
    mudGuessesTest.forEach((element) {
      if(element.manufacturer_name == null){
        element.manufacturer_name = "noInfo".tr().toString();
      }
      if(element.model_name == null){
        element.model_name = "noInfo".tr().toString();
      }
    });

    return mudGuessesTest;

    dynamic _handleTimeOut() {}
  }
}
