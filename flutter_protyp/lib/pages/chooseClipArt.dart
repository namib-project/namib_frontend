import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';

class ChooseClipart extends StatefulWidget {
  ChooseClipart({
    Key key,
    @required this.device,
  }) : super(key: key);

  final Device device;

  _ChooseClipartState createState() => _ChooseClipartState();
}

//Class for user registration, will only be used at the first usage
class _ChooseClipartState extends State<ChooseClipart> {
  /// A string that safes the selected clipart from the clipart-list
  String _selectedClipArt = allClipArts[0];

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: SelectableText(
          'details'.tr().toString(),
        ),
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
                Container(
                  height: 50,
                  child: SelectableText(
                    'iconChoice'.tr().toString(),
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: GestureDetector(
                    child: Container(
                      height: 200,
                      width: 200,
                      child: SvgPicture.asset(
                        _selectedClipArt,
                        color: Color(int.parse(widget.device.room.color)),
                        semanticsLabel: 'phone',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: SelectableText(
                    'chooseFittingIcon'.tr().toString(),
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20,
                    ),
                  ),
                ),
                _clipArtOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _clipArtOptions() {
    return Container(
      width: 500,
      height: 500,
      child: Column(
        children: <Widget>[
          Container(
            width: 400,
            height: 400,
            child: GridView.builder(
              itemCount: allClipArts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                var clipArt = allClipArts[index];
                return GestureDetector(
                  child: Container(
                    child: SvgPicture.asset(
                      clipArt,
                      semanticsLabel: 'phone',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedClipArt = clipArt;
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Buttons to accept or dismiss the changes like described above
              TextButton(
                child: Text(
                  'cancel'.tr().toString(),
                  style: TextStyle(
                    color: buttonColor,
                    fontSize: 18,
                  ),
                ),
                onPressed: () => {
                  Navigator.pushReplacementNamed(context, "/deviceOverview")
                },
              ),
              TextButton(
                  child: Text(
                    'confirm'.tr().toString(),
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () => {
                        if (allClipArts.contains(_selectedClipArt))
                          {
                            _putDevice(),
                          },
                      }),
            ],
          ),
        ],
      ),
    );
  }

  /// TODO
  _putDevice() async {
    String _deviceId = widget.device.id.toString();
    String _deviceExtension = "devices/$_deviceId";
    var response;

    Map<String, dynamic> _data = {
      "clipart": _selectedClipArt,
      "mud_url": widget.device.mud_url,
      "room_id": widget.device.room.id,
    };

    response = await http.put(url + _deviceExtension,
        body: jsonEncode(_data),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwtToken"
        });

    {
      Navigator.pushReplacementNamed(context, "/deviceOverview");
    }
  }
}
