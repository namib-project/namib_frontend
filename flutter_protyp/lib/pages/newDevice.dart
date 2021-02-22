import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:easy_localization/easy_localization.dart';

class NewDevice extends StatefulWidget {
  @override
  _NewDeviceState createState() => _NewDeviceState();
}

class _NewDeviceState extends State<NewDevice> {
  // for sorting the profileTable
  bool sortFirstRow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: SelectableText(
                          "Geräteerstellung",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: SelectableText(
                          "Wählen Sie ein passendes Profil",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 250,
                        width: 350,
                        child: SingleChildScrollView(
                          // TODO: show only when profiles exist; sort has to be implemented; Fill with real information and delete examples

                          child: DataTable(
                            sortColumnIndex: 0,
                            sortAscending: sortFirstRow,
                            columns: <DataColumn>[
                              DataColumn(
                                label: SelectableText("Profilname"),
                                numeric: false,
                                onSort: (i, b) {},
                              ),
                              DataColumn(
                                label: SelectableText(
                                  "Details",
                                ),
                              ),
                              DataColumn(
                                label: SelectableText(
                                  "Wahl",
                                ),
                              ),
                            ],

                            /// just exampleData
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(
                                    SelectableText("Profil1"),
                                  ),
                                  DataCell(
                                    Theme(
                                      data: ThemeData(
                                        brightness: darkMode
                                            ? Brightness.dark
                                            : Brightness.light,
                                        primaryColor: primaryColor,
                                        accentColor: primaryColor,
                                        hintColor: Colors.grey,
                                      ),
                                      child: IconButton(
                                        icon: FaIcon(FontAwesomeIcons.search),
                                        onPressed: () {
                                          print("iconButtonTest");
                                        },
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Checkbox(
                                        activeColor: buttonColor,
                                        value: true,
                                        onChanged: (bool value) {}),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    SelectableText("Profil2"),
                                  ),
                                  DataCell(
                                    Theme(
                                      data: ThemeData(
                                        brightness: darkMode
                                            ? Brightness.dark
                                            : Brightness.light,
                                        primaryColor: primaryColor,
                                        accentColor: primaryColor,
                                        hintColor: Colors.grey,
                                      ),
                                      child: IconButton(
                                        icon: FaIcon(FontAwesomeIcons.search),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Checkbox(
                                        activeColor: buttonColor,
                                        value: false,
                                        onChanged: (bool value) {}),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    SelectableText("Profil3"),
                                  ),
                                  DataCell(
                                    Theme(
                                      data: ThemeData(
                                        brightness: darkMode
                                            ? Brightness.dark
                                            : Brightness.light,
                                        primaryColor: primaryColor,
                                        accentColor: primaryColor,
                                        hintColor: Colors.grey,
                                      ),
                                      child: IconButton(
                                        icon: FaIcon(FontAwesomeIcons.search),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Checkbox(
                                        activeColor: buttonColor,
                                        value: false,
                                        onChanged: (bool value) {}),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    SelectableText("Profil4"),
                                  ),
                                  DataCell(
                                    Theme(
                                      data: ThemeData(
                                        brightness: darkMode
                                            ? Brightness.dark
                                            : Brightness.light,
                                        primaryColor: primaryColor,
                                        accentColor: primaryColor,
                                        hintColor: Colors.grey,
                                      ),
                                      child: IconButton(
                                        icon: FaIcon(FontAwesomeIcons.search),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Checkbox(
                                        activeColor: buttonColor,
                                        value: false,
                                        onChanged: (bool value) {}),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    SelectableText("Profil5"),
                                  ),
                                  DataCell(
                                    Theme(
                                      data: ThemeData(
                                        brightness: darkMode
                                            ? Brightness.dark
                                            : Brightness.light,
                                        primaryColor: primaryColor,
                                        accentColor: primaryColor,
                                        hintColor: Colors.grey,
                                      ),
                                      child: IconButton(
                                        icon: FaIcon(FontAwesomeIcons.search),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Checkbox(
                                        activeColor: buttonColor,
                                        value: false,
                                        onChanged: (bool value) {}),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    SelectableText("Profil6"),
                                  ),
                                  DataCell(
                                    Theme(
                                      data: ThemeData(
                                        brightness: darkMode
                                            ? Brightness.dark
                                            : Brightness.light,
                                        primaryColor: primaryColor,
                                        accentColor: primaryColor,
                                        hintColor: Colors.grey,
                                      ),
                                      child: IconButton(
                                        icon: FaIcon(FontAwesomeIcons.search),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Checkbox(
                                        activeColor: buttonColor,
                                        value: false,
                                        onChanged: (bool value) {}),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: SelectableText(
                          "Und Wählen Sie einen Gerätenamen",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: 350,
                        alignment: Alignment.center,
                        child: TextField(
                          obscureText: false,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Raumname"),
                        ),
                      ),
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                "Abbrechen",
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            FlatButton(
                              child: Text(
                                "Bestätigen",
                                style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
