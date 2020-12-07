import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";

/// returns a site to create MOD-Profiles with different parameters

class CreateMudProfile extends StatefulWidget {
  @override
  _CreateMudProfileState createState() => _CreateMudProfileState();
}

bool value = false;



class _CreateMudProfileState extends State<CreateMudProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'NewMUDProfile'.trim().toString(),
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
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Profilname"),
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "IoT-Geräte-Version"),
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "MAC-Adresse"),
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Profilname"),
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Protokollversion"),
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Sicherheitsalgorithmus"),
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "MUD-URL"),
            ),
            CheckboxListTile(
              title: Text("grease_extension"),
              value: value,
              onChanged: (newValue) {
                setState(() {
                  
                  value = newValue;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
            )
          ],
        ),
        )
        )
      );
  }
}