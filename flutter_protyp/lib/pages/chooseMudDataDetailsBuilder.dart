import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/mudData.dart';
import 'package:flutter_protyp/pages/chooseMudDataDetails.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:http/http.dart' as http;
import 'package:url_encoder/url_encoder.dart';
import 'dart:convert';


class ChooseMudDataDetails extends StatefulWidget {
  const ChooseMudDataDetails({
    Key key,
    @required this.mudGuessUrl,
  }) : super(key: key);
  final String mudGuessUrl;

  _ChooseMudDataDetailsState createState() => _ChooseMudDataDetailsState();
}

class _ChooseMudDataDetailsState extends State<ChooseMudDataDetails> {
  Future<List<MUDData>> _mudDataFuture;

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
                              context, "/chooseMudDataDetails");
                        },
                      )
                    ],
                  ),
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

  Future<List<MUDData>> _getMudDataFuture() async {
    String _mudDataExtension = 'mud/';
    var _response;
    String _urlExtension = "?mud_url=";
    String _urlEncodedMudUrl = urlEncode(text: widget.mudGuessUrl).toString();

    _response = await http.get(
        url + _mudDataExtension + _urlExtension + _urlEncodedMudUrl,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        }).timeout(const Duration(seconds: 5), onTimeout: () {
      return null;
    });

    if (_response.statusCode == 200) {
      var jsonMudData = jsonDecode(_response.body) as List;
      List<MUDData> mudDataTest =
          jsonMudData.map((e) => MUDData.fromJson(e)).toList();
      return mudDataTest;
    } else {
      throw Exception("Failed to get Data");
    }
  }
}
