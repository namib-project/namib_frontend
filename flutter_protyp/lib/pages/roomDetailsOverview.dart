import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flex_color_picker/flex_color_picker.dart';

class RoomDetailsOverview extends StatefulWidget {
  const RoomDetailsOverview({
    Key key,
    @required this.room,
  }) : super(key: key);

  final Room room;

  @override
  _RoomDetailsOverviewState createState() => _RoomDetailsOverviewState();
}

class _RoomDetailsOverviewState extends State<RoomDetailsOverview> {
  String _newRoomName;
  Color _newColor;

  // Define some custom colors for the custom picker segment.
  // The 'guide' color values are from
  // https://material.io/design/color/the-color-system.html#color-theme-creation
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newColor = Color(int.parse(widget.room.color));
    _newRoomName = widget.room.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            size: 17,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/editRoom");
          },
        ),
        title: SelectableText("Details"),
        actions: <Widget>[
          Padding(
            padding: mobileDevice
                ? EdgeInsets.fromLTRB(12, 5, 12, 12)
                : EdgeInsets.fromLTRB(0, 5, 12, 12),
            child: SettingsPopup(),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                SelectableText(
                  widget.room.name,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    _showColorAlertDialog(context);
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _newColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 400,
                  child: TextField(
                    obscureText: false,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'roomName'.tr().toString(),
                    ),
                    onChanged: (txt) {
                      setState(() {
                        _newRoomName = txt;
                      });
                    },
                  ),
                ),
                _bottomButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bottomButtons() {
    return Container(
      height: 70,
      width: 400,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            child: Text(
              'cancel'.tr().toString(),
              style: TextStyle(
                color: buttonColor,
                fontSize: 18,
              ),
            ),
            onPressed: () {
              _forward();
            },
          ),
          TextButton(
            child: Text(
              'save'.tr().toString(),
              style: TextStyle(
                color: buttonColor,
                fontSize: 18,
              ),
            ),
            onPressed: _updateRoomButton()
                ? () {
                    _updateRoom();
                  }
                : null,
          ),
        ],
      ),
    );
  }

  bool _updateRoomButton() {
    if (widget.room.name != _newRoomName ||
        widget.room.color != _newColor.value.toString()) {
      return true;
    }
    return false;
  }

  _updateRoom() async {
    String updateRoomExtension = "rooms/";
    String roomId = widget.room.id.toString();
    var _response;

    Map<String, dynamic> data = {
      "color": _newColor.value.toString(),
      "name": _newRoomName,
    };

    _response = await http
        .put(
          url + updateRoomExtension + roomId,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $jwtToken"
          },
          body: jsonEncode(data),
        )
        .timeout(Duration(seconds: 5));
    _forward();
  }

  void _forward() {
    Navigator.pushReplacementNamed(context, "/editRoom");
  }

  // Gives the colorPicker AlertDialog with the colors above
  _showColorAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Theme(
            data: ThemeData(
              brightness: darkMode ? Brightness.dark : Brightness.light,
              primaryColor: primaryColor,
              accentColor: primaryColor,
              hintColor: Colors.grey,
            ),
            child: AlertDialog(
              scrollable: true,
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
                          color: _newColor,
                          onColorChanged: (Color color) =>
                              setState(() => _newColor = color),
                          width: 50,
                          height: 50,
                          elevation: 0,
                          borderRadius: 4,
                          padding: EdgeInsets.fromLTRB(6, 10, 6, 0),
                          heading: Text(
                            "selectColor".tr().toString(),
                            style: TextStyle(
                              fontSize: 22,
                              color: darkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          subheading: Text(
                            "selectShade".tr().toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: darkMode ? Colors.white : Colors.black,
                            ),
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
                          child: TextButton(
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
        );
      },
    );
  }
}
