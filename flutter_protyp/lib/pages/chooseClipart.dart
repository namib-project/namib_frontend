import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_protyp/data/device_mud/device.dart';
import 'package:flutter_protyp/pages/chooseMudData.dart';
import 'package:flutter_protyp/pages/deviceDetails.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_svg/flutter_svg.dart';

class ChooseClipart extends StatefulWidget {
  _ChooseClipartState createState() => _ChooseClipartState();
}

//Class for user registration, will only be used at the first usage
class _ChooseClipartState extends State<ChooseClipart> {
  /// A string that safes the selected clipart from the clipart-list
  String selectedClipArt = allClipArts[0];

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MainAppbar(),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: SelectableText(
                    'Iconauswahl'.tr().toString(),
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
                        selectedClipArt,
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
                    "Wählen Sie ein passendes Icon",
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
                      selectedClipArt = clipArt;
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
              FlatButton(
                child: Text(
                  "Abbrechen",
                  style: TextStyle(
                    color: buttonColor,
                    fontSize: 18,
                  ),
                ),
                onPressed: () => {
                  Navigator.pushReplacementNamed(context, "/deviceOverview")
                },
              ),
              FlatButton(
                child: Text(
                  "Bestätigen",
                  style: TextStyle(
                    color: buttonColor,
                    fontSize: 18,
                  ),
                ),
                onPressed: () => {
                  Navigator.pushReplacementNamed(context, "/deviceOverview")
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
