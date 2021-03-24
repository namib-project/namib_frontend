import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:easy_localization/easy_localization.dart';

// This class comes up if your user dont have any permissions on the application
// Just a small text that inform you about your options

class Dummie extends StatefulWidget {
  @override
  _DummieState createState() => _DummieState();
}

class _DummieState extends State<Dummie> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppbar(),
        //drawer: MainDrawer(),
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
                      "dummieUser".tr().toString(),
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
                ],
              ),
            )));
  }



}