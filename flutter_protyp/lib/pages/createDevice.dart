

import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:flutter_protyp/widgets/constant.dart';

import 'package:easy_localization/easy_localization.dart';


class CreateDevice extends StatefulWidget {
  @override
  _CreateDeviceState createState() => _CreateDeviceState();
}

class _CreateDeviceState extends State<CreateDevice> {
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
                  'newDevice'.tr().toString(),
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
              ],
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Spezifikation"),
            ),
            Visibility(
                visible: expertMode,
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
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text('Speichern'),
                  color: Colors.deepOrange,
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text('Abbrechen'),
                  color: Colors.deepOrange,
                  onPressed: () {Navigator.pushReplacementNamed(context, "/deviceOverview");},
                ),
              ],
            ),
            const SizedBox(height: 30),

          ],
        ),
      )),
    );
  }
}
