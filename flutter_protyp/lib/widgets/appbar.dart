import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/handlers/ThemeChangeHandler.dart';
import "package:flutter_protyp/widgets/constant.dart";
import 'package:provider/provider.dart';
import 'package:flutter_protyp/widgets/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Gives an AppBar with logoutButton
// Can be coloured with primaryColor in constant.dart

class MainAppbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _MainAppbarState createState() => _MainAppbarState();

  @override
  Size get preferredSize {
    return new Size.fromHeight(kToolbarHeight);
  }
}

/// Var for showing username in appbar (little parser for http response)
String username;
String myJson;
Map clearJson;
String token;
var parts = null;
var payload = null;
var normalized;
var resp;
var payloadMap;

class _MainAppbarState extends State<MainAppbar> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);

    return SizedBox(
      child: AppBar(
        backgroundColor: primaryColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(FontAwesomeIcons.bars),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: 'openNavigation'.tr().toString(),
            );
          },
        ),

        // Text field for displaying the username
        title: SelectableText("hello".tr().toString() + " " + getUserName()),
        actions: <Widget>[
          Padding(
            padding: mobileDevice
                ? EdgeInsets.fromLTRB(12, 5, 12, 12)
                : EdgeInsets.fromLTRB(0, 5, 12, 12),
            child: SettingsPopup(),
          ),
        ],
      ),
    );
  }

  // This method parses the string with username from controller
  String getUserName() {
    if (jwtToken.length > 1) {
      myJson = jwtToken;
      parts = myJson.split('.');
      payload = parts[1];
      normalized = base64Url.normalize(payload);
      resp = utf8.decode(base64Url.decode(normalized));
      payloadMap = json.decode(resp);
      username = payloadMap["username"];
    } else {
      username = "";
    }
    return username;
  }
}

class SettingsPopup extends StatefulWidget {
  @override
  _SettingsPopupState createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);

    return PopupMenuButton<Widget>(
      icon: Center(
        child: Icon(
          FontAwesomeIcons.user,
          size: mobileDevice ? 20 : 25,
        ),
      ),
      tooltip: 'openMenu'.tr().toString(),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Switch to change the Dark / LightMode
                SwitchListTile(
                  title: Text(
                    "Dark mode",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  activeColor: buttonColor,
                  value: darkMode,
                  onChanged: (bool value) {
                    setDarkMode(setState, themeChanger);
                  },
                ),
                // Switch to change expert mode/normal mode
                SwitchListTile(
                  title: Text(
                    "expertMode".tr().toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  activeColor: buttonColor,
                  value: expertMode,
                  onChanged: (bool value) {
                    setExpertMode(setState, value);
                  },
                ),

                // Switch to change languages
                Container(
                  width: 250,
                  height: 50,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        for (int i = 0; i < selectionsLanguage.length; i++) {
                          selectionsLanguage[i] = !selectionsLanguage[i];
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
                    child: Container(
                      width: 300,
                      height: 50,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              'language'.tr().toString(),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
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
                                  setLanguage(setState, index, context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),

                // Button to get user information
                Container(
                  width: 300,
                  height: 50,
                  alignment: Alignment.center,
                  child: InkWell(
                    splashColor: buttonColor,
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/manageUser");
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        "manageUser".tr().toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),

                Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),

                // Logoutbutton
                Container(
                  width: 300,
                  height: 50,
                  alignment: Alignment.center,
                  child: InkWell(
                    splashColor: buttonColor,
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/login");
                      permissions = [];
                      jwtToken = "";
                      adminAccess = false;
                      userAccess = false;
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
      offset: Offset(0, 100),
    );
  }

  // This method activates the expert mode, if the devices is new, its default turned out
  // otherwise its saved in the system variables
  void setExpertMode(StateSetter setState, bool value) {
    ThemeChangeHandler handler = ThemeChangeHandler();
    setState(() {
      handler.changeExpertMode(value, context);
    });
    handler.setExpertModeUserConfig(expertMode);
  }

  // This method activates the dark mode, if the devices is new, its default turned out
  // otherwise its saved in the system variables
  void setDarkMode(StateSetter setState, ThemeChanger themeChanger) {
    ThemeChangeHandler handler = ThemeChangeHandler();
    setState(() {
      handler.changeDarkMode(context);
    });
    handler.setDarkModeUserConfig(darkMode);
  }

  // This method activates the language the user selected, the default language
  // is from the operating system
  void setLanguage(StateSetter setState, int index, BuildContext context) {
    ThemeChangeHandler handler = new ThemeChangeHandler();
    setState(() {
      handler.setLanguage(index, context);
    });
    handler.setLanguageUserConfig(language);
  }
}
