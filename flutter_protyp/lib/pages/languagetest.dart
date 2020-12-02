import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:easy_localization/easy_localization.dart';

/// just for testing can be deleted

class LanguageTest extends StatefulWidget {
  @override
  _LanguageTestState createState() => _LanguageTestState();
}

class _LanguageTestState extends State<LanguageTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr().toString()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'hello'.tr().toString(),
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  // Set german language
                  setState(() {
                    EasyLocalization.of(context).locale = Locale('de', 'DE');
                  });
                },
                child: Text("Deutsch"),
              ),
              RaisedButton(
                onPressed: () {
                  // Set english language
                  setState(() {
                    EasyLocalization.of(context).locale = Locale('en', 'US');
                  });
                },
                child: Text("English"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
