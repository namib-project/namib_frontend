import 'package:flutter/material.dart';
import "package:flutter_protyp/widgets/constant.dart";

import 'package:easy_localization/easy_localization.dart';

/// Gives a Drawer in which the different sites are linked
/// Can be coloured with primaryColor and secondaryColor in constant.dart
class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                child: Text(
                  'menu'.tr().toString(),
                  style: TextStyle(fontSize: 20),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: <Color>[
                    secondaryColor,
                    primaryColor,
                  ],
                )),
              ),
            ),
            CustomListTile(
              icon: Icons.device_hub, // or maybe: ad_units
              text: 'deviceOverview'.tr().toString(),
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, "/deviceOverview")},
            ),
            CustomListTile(
              icon: Icons.add_rounded,
              text: 'newDevice'.tr().toString(),
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, "/createDevice")},
            ),
            CustomListTile(
              icon: Icons.bar_chart,
              text: 'networkBehaviour'.tr().toString(),
              onTap: () => {
                Navigator.pushReplacementNamed(context, "/networkbehaviour")
              },
            ),
            Visibility(
              // just for testing
              visible: expertMode,
              child: CustomListTile(
                icon: Icons.add_rounded,
                text: 'newMudProfile'.tr().toString(),
                onTap: () => {
                  Navigator.pushReplacementNamed(context, "/createMudProfile")
                },
              ),
            ),
            CustomListTile(
              icon: Icons.build_circle,
              text: "editDevice".tr().toString(),
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, "/editDevice")},
            ),
            CustomListTile(
              icon: Icons.person_add,
              text: "signup".tr().toString(),
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, "/registration")},
            ),
            CustomListTile(
              icon: Icons.account_circle,
              text: "Eigener Nutzer",
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, "/ownUser")},
            ),

            /// For testing JSON Serialization
            ///CustomListTile(
            ///  icon: Icons.account_circle,
            ///  text: "JSONTEST",
            ///  onTap: () =>
            ///      {Navigator.pushReplacementNamed(context, "/languagetest")},
            ///),
          ],
        ),
      ),
    );
  }
}

/// Gives a ListTile which is used in the drawer
/// Needs an icon and a text which will be displayed
/// and a function which will be executed on click
/// /// Can be coloured with buttonColor and secondaryColor in constant.dart
class CustomListTile extends StatefulWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  const CustomListTile({Key key, this.icon, this.text, this.onTap})
      : super(key: key);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[400],
            ),
          ),
        ),
        child: InkWell(
          splashColor: buttonColor,
          onTap: widget.onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(widget.icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.text,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
