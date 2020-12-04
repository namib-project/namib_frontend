import 'dart:io';

import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/widgets/appbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Class for editing devices for example change MUD-profile for this device

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  /// Variables just for testing has to be replaced with real data
  String mud = "MUD Profil";
  int number = 1;
  String test = "";

  ///True if mouse is in the MouseRegion widget, else false
  bool inRegion = false;

  //Creating the overlay element
  OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
            top: 340.0,
            right: 600,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.red,
              child: Text("test"),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Gerät bearbeiten",
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
                                      child: Text("Verstanden!"),
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
                    : MouseRegion( //MouseRegion for the hover element
                        onEnter: _enterInRegion,
                        onExit: _exitInRegion,
                        child: Icon(Icons.help_center),
                      ),
              ],
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Spezifikation"),
            ),
            Container(
                child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Gerätename"),
            )),
            Container(
              child: Text("$mud" + " " + "$number"),
            ),
            FloatingActionButton(
              heroTag: "mud-profile dialog",
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                          title: Text("MUD Profile"),
                          titleTextStyle:
                              TextStyle(fontSize: 30, color: Colors.black),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  number = 1;
                                });
                              },
                              child: Text("MUD Profil 1"),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  number = 2;
                                });
                              },
                              child: Text("MUD Profil 2"),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  number = 3;
                                });
                              },
                              child: Text("MUD Profil 3"),
                            ),
                          ],
                        ));
              },
              child: Icon(Icons.list),
            )
          ],
        ),
      )),
    );
  }
}
