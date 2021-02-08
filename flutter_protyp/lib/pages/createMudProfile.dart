import 'dart:io';

import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/widgets/appbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';

/// returns a site to create MOD-Profiles with different parameters

class CreateMudProfile extends StatefulWidget {
  @override
  _CreateMudProfileState createState() => _CreateMudProfileState();
}

class _CreateMudProfileState extends State<CreateMudProfile> {
  /// Variables just for testing has to be replaced with real data
  String mud = "MUD Profil";
  int number = 1;
  String test = "";

  ///True if mouse is in the MouseRegion widget, else false
  bool inRegion = false;

  //Creating the overlay element just an example for expert mode
  OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 400.0,
        right: 600,
        child: Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment(0, 0),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: darkMode ? Colors.black.withOpacity(0.9) : Colors.grey.withOpacity(0.9),
          ),
          child: Text("Hier könnte Ihre Werbung stehen",
            style: TextStyle(fontSize: 30,
                color: darkMode ? Colors.white : Colors.black,
                decoration: TextDecoration.none),),
        ),
      ));

  //Function that shows the overlay element
  showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    overlayState.insert(overlayEntry);
  }

  //Function for closing the overlay element

  closeOverlay() {
    overlayEntry.remove();
  }

  //Function called from MouseRegion widget below, opens the overlay on mouse enter
  void _enterInRegion(PointerEvent details) {
    setState(() {
      inRegion = true;
    });
    showOverlay(context);
  }

  //Function called from MouseRegion widget below, closes the overlay on mouse exit
  void _exitInRegion(PointerEvent details) {
    setState(() {
      inRegion = false;
    });
    closeOverlay();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
          child: Container(
            width: 400,
            //Context will appear smaller on mobile devices
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "newMudProfile".tr().toString(),
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      mobileDevice //if mobile device, then icon button with dialog, else icon with hover effect
                          ? IconButton(
                        icon: Icon(Icons.help_center),
                        iconSize: 30,
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Erklärung"),
                                  content:
                                  Text("Hier könnte Ihre Werbung stehen"),
                                  actions: [
                                    FlatButton(
                                      child: Text("Ok!"),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // dismiss dialog
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                      )
                          : MouseRegion(
                        //MouseRegion for the hover element
                        onEnter: _enterInRegion,
                        onExit: _exitInRegion,
                        child: Icon(Icons.help_center),
                      ),
                    ],
                  ),
                ),
                // Some textboxes for inputs for the mudprofile
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Profilname"),
                  ),
                ),
                Container(
                    height: 70,
                    alignment: Alignment.center,
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "IoT-Geräte-Version"),
                    )),
                Container(
                    height: 70,
                    alignment: Alignment.center,
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "MAC-Adresse"),
                    )),
                Container(
                    height: 70,
                    alignment: Alignment.center,
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Protokollversion"),
                    )),
                Container(
                    height: 70,
                    alignment: Alignment.center,
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "MUD-URL"),
                    )),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "save".tr().toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        padding: EdgeInsets.all(15),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "cancel".tr().toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        padding: EdgeInsets.all(15),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
