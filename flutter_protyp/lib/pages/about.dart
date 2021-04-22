import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

// This class implements the service to check the controller version

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  /// Variable to safe the version of the controller
  Future<String> version;

  // Future string type to build at runtime
  // Get request for the controller version to display it for the user
  Future<String> fetchVersion() async {
    try {
      String statusExtension = "status";
      var response = await http.get(url + statusExtension);

      if (response.statusCode == 200) {
        String data = utf8.decode(response.bodyBytes);
        var statusResponse = jsonDecode(data);
        return statusResponse["version"];
      }
    } on Exception {
      return 'Error';
    }
  }

  @override
  void initState() {
    super.initState();
    version = fetchVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                child: SelectableText(
                  "About",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: SelectableText(
                      "controllerVersion".tr().toString(),
                    ),
                  ),
                  Container(
                      // FutureBuilder element, that will be build but context will be shown after get request above
                      // Here will be presented the current controller version
                      child: FutureBuilder<String>(
                    future: version,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SelectableText(snapshot.data);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
