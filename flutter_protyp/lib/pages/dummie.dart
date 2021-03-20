import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;




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