import 'dart:io';

import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:flutter_protyp/widgets/appbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// just for testing can be deleted

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  String mud = "MUD Profil";
  int number = 1;

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
              children: <Widget>[
                Text(
                  "Gerät bearbeiten",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.help),
                    iconSize: 30,
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Erklärung"),
                              content: Text("Hier könnte Ihre Werbung stehen"),
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
                    }),
                FloatingActionButton(
                  heroTag: "help dialog",
                  onPressed: () {
                    showGeneralDialog(
                      barrierLabel: "Label",
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.7),
                      transitionDuration: Duration(milliseconds: 700),
                      context: context,
                      pageBuilder: (context, anim1, anim2) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 500,
                            width: 400,
                            child: SizedBox.expand(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 25),
                              child: Text(
                                "Hier könnte Ihre Werbung stehen",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    decoration: TextDecoration.none),
                              ),
                            )),
                            margin: EdgeInsets.only(
                                bottom: 50, left: 12, right: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        );
                      },
                      transitionBuilder: (context, anim1, anim2, child) {
                        return SlideTransition(
                          position:
                              Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                  .animate(anim1),
                          child: child,
                        );
                      },
                    );
                  },
                  child: Icon(Icons.help_center),
                )
              ],
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Spezifikation"),
            ),
            Visibility(
                visible: expertMode,
                child: TextField(
                  obscureText: true,
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
