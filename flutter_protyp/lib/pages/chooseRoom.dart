import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import "package:flutter_protyp/widgets/drawer.dart";
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

import 'package:easy_localization/easy_localization.dart';

class ChooseRoom extends StatefulWidget {
  @override
  _ChooseRoomState createState() => _ChooseRoomState();
}

class _ChooseRoomState extends State<ChooseRoom> {
  bool sortFirstRow = false;
  Color currentColor = Colors.red;

  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };

  void changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  showAlertDialog(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: ThemeData(
            primaryColor: primaryColor,
            accentColor: primaryColor,
            hintColor: Colors.grey,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Theme(
                data: ThemeData(
                  brightness: darkMode ? Brightness.dark : Brightness.light,
                  primaryColor: primaryColor,
                  accentColor: primaryColor,
                  hintColor: Colors.grey,
                ),
                child: AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  content: Container(
                    width: 300,
                    height: 470,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Card(
                            elevation: 0,
                            child: ColorPicker(
                              color: currentColor,
                              onColorChanged: (Color color) =>
                                  setState(() => currentColor = color),
                              width: 50,
                              height: 50,
                              elevation: 0,
                              borderRadius: 4,
                              padding: EdgeInsets.fromLTRB(6, 10, 6, 0),
                              heading: Text(
                                "selectColor".tr().toString(),
                                style: TextStyle(
                                    fontSize: 22,
                                    color:
                                        darkMode ? Colors.white : Colors.black),
                              ),
                              subheading: Text(
                                "selectShade".tr().toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        darkMode ? Colors.white : Colors.black),
                              ),
                              pickersEnabled: const <ColorPickerType, bool>{
                                ColorPickerType.primary: true,
                                ColorPickerType.accent: false,
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: FlatButton(
                                child: Text(
                                  "Ok",
                                  style: TextStyle(
                                    color: buttonColor,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: SelectableText(
                          "Raumwahl",
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
                          "Wählen Sie einen Raum",
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
                          // TODO: show only when rooms exists; sort has to be implemented; Fill with real information and delete examples

                          child: DataTable(
                            sortColumnIndex: 0,
                            sortAscending: sortFirstRow,
                            columns: <DataColumn>[
                              DataColumn(
                                label: SelectableText("Raum"),
                                numeric: false,
                                onSort: (i, b) {},
                              ),
                              DataColumn(
                                label: SelectableText(
                                  "Farbe",
                                ),
                              ),
                              DataColumn(
                                label: SelectableText(
                                  "Wählen",
                                ),
                              ),
                            ],

                            /// just exampleData
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(
                                    SelectableText("Küche"),
                                  ),
                                  DataCell(
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  DataCell(Checkbox(
                                      activeColor: buttonColor,
                                      value: true,
                                      onChanged: (bool value) {})),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    SelectableText("Badezimmer"),
                                  ),
                                  DataCell(
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  DataCell(Checkbox(
                                      activeColor: buttonColor,
                                      value: false,
                                      onChanged: (bool value) {})),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    SelectableText("Wohnzimmer"),
                                  ),
                                  DataCell(
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  DataCell(Checkbox(
                                      activeColor: buttonColor,
                                      value: false,
                                      onChanged: (bool value) {})),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    SelectableText("Schlafzimmer"),
                                  ),
                                  DataCell(
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  DataCell(Checkbox(
                                      activeColor: buttonColor,
                                      value: false,
                                      onChanged: (bool value) {})),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    SelectableText("Flur"),
                                  ),
                                  DataCell(
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  DataCell(Checkbox(
                                      activeColor: buttonColor,
                                      value: false,
                                      onChanged: (bool value) {})),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: SelectableText(
                          "Oder erstellen Sie einen neuen",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Container(
                              height: 50,
                              width: 280,
                              child: TextField(
                                obscureText: false,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Raumname"),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                showAlertDialog(context);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: currentColor,
                                ),
                              ),
                            ),
                          ],
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
