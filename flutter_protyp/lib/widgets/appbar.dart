import 'package:flutter/material.dart';
import "package:flutter_protyp/widgets/constant.dart";
import 'package:provider/provider.dart';
import 'package:flutter_protyp/widgets/theme.dart';

import 'package:easy_localization/easy_localization.dart';

/// Gives an AppBar with logoutButton
/// Can be coloured with primaryColor in constant.dart
class MainAppbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _MainAppbarState createState() => _MainAppbarState();

  @override
  Size get preferredSize {
    return new Size.fromHeight(kToolbarHeight);
  }
}

class _MainAppbarState extends State<MainAppbar> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);

    return SizedBox(
        child: AppBar(
      backgroundColor: primaryColor,
      title: Text("NAMIB"),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.all(12),
          child: PopupMenuButton<String>(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /// Switch to change the Dark / LightMode
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Dark mode",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Switch(
                              value: darkMode,
                              activeColor: buttonColor,
                              onChanged: (bool s) {
                                setState(() {
                                  darkMode
                                      ? themeChanger.setTheme(ThemeData.light())
                                      : themeChanger.setTheme(ThemeData.dark());
                                  darkMode = !darkMode;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      /// Switch to change ExpertMode
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'expertMode'.tr().toString(),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Switch(
                              value: expertMode,
                              activeColor: buttonColor,
                              onChanged: (bool s) {
                                setState(() {
                                  expertMode = s;
                                });
                              },
                            )
                          ],
                        ),
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'language'.tr().toString(),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              height: 30,
                              child: ToggleButtons(
                                children: <Widget>[
                                  Text("DE"),
                                  Text("EN"),
                                ],
                                selectedColor: secondaryColor,
                                fillColor: lightFillColor,
                                borderRadius: BorderRadius.circular(8),
                                borderWidth: 2,
                                borderColor: Colors.grey,
                                selectedBorderColor: Colors.grey,
                                isSelected: selectionsLanguage,
                                onPressed: (int index) {
                                  setState(() {
                                    for (int buttonIndex = 0;
                                        buttonIndex < selectionsLanguage.length;
                                        buttonIndex++) {
                                      if (buttonIndex == index) {
                                        selectionsLanguage[buttonIndex] = true;
                                      } else {
                                        selectionsLanguage[buttonIndex] = false;
                                      }
                                    }
                                    if (selectionsLanguage[0]) {
                                      setState(() {
                                        EasyLocalization.of(context).locale =
                                            Locale('de', 'DE');
                                      });
                                    } else {
                                      setState(() {
                                        EasyLocalization.of(context).locale =
                                            Locale('en', 'US');
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 300,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        child: InkWell(
                          splashColor: buttonColor,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, "/userManagement");
                          },
                          child: Container(
                            width: 300,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "Benutzer verwalten",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: 300,
                        height: 50,
                        alignment: Alignment.center,
                        child: InkWell(
                          splashColor: buttonColor,
                          onTap: () {
                            Navigator.pushReplacementNamed(context, "/login");
                            jwtToken = "";
                          },
                          child: Container(
                            width: 300,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),

                      /// Saving the variable of the language and deciding whether the application is shown in German or English.
                      /// The entire translation is handled in flutter_prototyp/resources/langs/[de-DE.json / en-US.json]
                    ],
                  );
                }),
              ),
            ],
            icon: Icon(
              Icons.account_box_rounded,
              size: 30,
            ),
            offset: Offset(0, 100),
          ),
        ),
      ],
    ));
  }
}
