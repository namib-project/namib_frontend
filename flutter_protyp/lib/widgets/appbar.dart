import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_protyp/pages/handlers/ThemeHandler.dart';
import "package:flutter_protyp/widgets/constant.dart";
import 'package:provider/provider.dart';
import 'package:flutter_protyp/widgets/theme.dart';
import 'package:http/http.dart' as http;
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

String username;
String myJson;
Map clearJson;
String token;
var parts = null;
var payload = null;
var normalized;
var resp;
var payloadMap;

String url = 'http://172.25.32.1:8000/users/me';
var response;

class _MainAppbarState extends State<MainAppbar> {
  @override
  Widget build(BuildContext context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    //getUserName();

    return SizedBox(
        child: AppBar(
      backgroundColor: primaryColor,
      title: SelectableText("hello".tr().toString() + " " + getUserName()),
      actions: <Widget>[
        Padding(
          padding: mobileDevice
              ? EdgeInsets.fromLTRB(12, 5, 12, 12)
              : EdgeInsets.fromLTRB(12, 2, 12, 12),
          child: PopupMenuButton<String>(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /// Switch to change the Dark / LightMode
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

                      Container(
                        width: 250,
                        height: 50,
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              for (int i = 0;
                                  i < selectionsLanguage.length;
                                  i++) {
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

                      Container(
                        width: 300,
                        height: 50,
                        alignment: Alignment.center,
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

                      Container(
                        width: 300,
                        height: 50,
                        alignment: Alignment.center,
                        child: InkWell(
                          splashColor: buttonColor,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, "/loginTest");
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

  void setExpertMode(StateSetter setState, bool value) {
    ThemeChangeHandler handler = ThemeChangeHandler();
    setState(() {
      handler.changeExpertMode(value);
    });
  }

  void setDarkMode(StateSetter setState, ThemeChanger themeChanger) {
    ThemeChangeHandler handler = ThemeChangeHandler();
    setState(() {
      handler.changeDarkMode(context);
    });
  }

  void setLanguage(StateSetter setState, int index, BuildContext context) {
    ThemeChangeHandler handler = new ThemeChangeHandler();
    setState(() {
      handler.setLanguage(index, context);
    });
  }

  String getUserName() {
    ///TODO delete if for release
    if(jwtToken.length > 1) {
      myJson = jwtToken;
      //clearJson = jsonDecode(myJson);
      //token = clearJson["token"];
      parts = myJson.split('.');
      payload = parts[1];
      normalized = base64Url.normalize(payload);
      resp = utf8.decode(base64Url.decode(normalized));
      payloadMap = json.decode(resp);
      //  print(payloadMap["id"]);
      //  print(payloadMap["username"]);
      username = payloadMap["username"];
    }else{
      username = "test";
    }
    //response = await http.get(url, headers: {
    //  "Content-Type": "application/json",
    //  "Authorization": "Bearer $jwtToken"
    //});

    //username = response.body;
    return username;
  }
}
