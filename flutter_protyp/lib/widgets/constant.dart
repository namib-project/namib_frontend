import 'package:flutter/material.dart';

/// Here are variables which are global and can be accessed from everywhere

/// These are accent colour constants of the application
/// should not be changed anywhere
Color primaryColor = Colors.orange[600];
const Color secondaryColor =
    Colors.deepOrange; // Color.fromRGBO(66, 152, 219, 1);
Color buttonColor = Colors.orange[800]; // Color.fromRGBO(36, 134, 255, 1);
Color lightFillColor =
    Colors.orange[100]; // is used in Drawer settings languageSwitch
Color loginColor1 = Colors.orange[200];
Color loginColor2 = Colors.deepOrange;

/// these are the different modes of the application
/// should only be changed in settings in themeChanger
/// List with languages german is entry 0, english is entry 1
/// initial setting is german
List<bool> selectionsLanguage = [true, false];
bool expertMode = false;
bool darkMode = false;
bool mobileDevice = false;
String language = "en";
String jwtToken = "";
String url = "/";
List<dynamic> permissions = [];
int userID;
int roleID;

///Variables for permissions
bool adminAccess = false;
bool userAccess = false;

/// this is for all the clipart pictures
/// is used in chooseClipArt.dart
final List<String> allClipArts = [
  'resources/clipart/settings_suggest.svg',
  'resources/clipart/cloud.svg',
  'resources/clipart/desktop_windows.svg',
  'resources/clipart/lamp.svg',
  'resources/clipart/laptop.svg',
  'resources/clipart/lightning.svg',
  'resources/clipart/music_note_beamed.svg',
  'resources/clipart/phone_iphone.svg',
  'resources/clipart/router.svg',
  'resources/clipart/smartphone.svg',
  'resources/clipart/speaker.svg',
  'resources/clipart/sun.svg',
  'resources/clipart/thermometer.svg',
  'resources/clipart/tv.svg'
];
