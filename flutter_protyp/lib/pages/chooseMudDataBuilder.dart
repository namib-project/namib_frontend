import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/device_mud/mudGuess.dart';
import 'package:flutter_protyp/pages/chooseMudDataTableOverview.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

/// This class contains the MUD-Geusses functions

class ChooseMudData extends StatefulWidget {
  ChooseMudData({
    Key key,
    @required this.device,
  }) : super(key: key);

  /// A new device
  final Device device;

  _ChooseMudDataState createState() => _ChooseMudDataState();
}

class _ChooseMudDataState extends State<ChooseMudData> {
  /// A list for MUD-Guesses
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
      body: Center(
        child: Column(
          children: [
            /// This future builder element put in the different devices after these will be loaded
            /// The future builder element a delayed sending of context

            FutureBuilder<List<MudGuess>>(
              future: mudGuessList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ChooseMudDataTable(
                      mudGuessList: snapshot.data,
                      device: widget.device,
                    ),
                  );
                } else if (snapshot.hasError) {
                  /// If the process failed this message returns
                  print(snapshot.error);
                  return Container(
                    width: 600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SelectableText("wentWrongError".tr().toString()),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(120, 50)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              buttonColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/chooseRoom");
                          },
                          child: Text(
                            "reload".tr().toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
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
          ],
        ),
      ),
    );
  }

  /// This function gets the MUD-Guesses list from the controller
  Future<List<MudGuess>> getMudGuessList() async {
    String id = widget.device.id.toString();
    String mudGuessExtension = 'devices/$id/guesses';

    response = await http.get(url + mudGuessExtension, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken"
    }).timeout(const Duration(seconds: 5), onTimeout: () {
      return null;
    });

    if (response.statusCode == 200) {
      String _data = utf8.decode(response.bodyBytes);
      var jsonMudGuesses = jsonDecode(_data) as List;
      List<MudGuess> mudGuessesTest =
          jsonMudGuesses.map((tagJson) => MudGuess.fromJson(tagJson)).toList();

      mudGuessesTest.forEach((element) {
        if (element.manufacturer_name == null) {
          element.manufacturer_name = "noInfo".tr().toString();
        }
        if (element.model_name == null) {
          element.model_name = "noInfo".tr().toString();
        }
      });

      return mudGuessesTest;
    }
  }
}
