import 'package:flutter/material.dart';
import 'package:flutter_protyp/dataForPresentation/device.dart';

import 'package:flutter_protyp/dataForPresentation/service.dart';

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
String url = "http://192.168.240.1:8000/";
List<dynamic> permissions = ["read_permission", "write_permission"];
///Variables for permissions
bool adminAccess = false;
bool userAccess = false;

List<String> allowedDNSRequests = [
  "www.example.net",
  "0.north-america.pool.ntp.org",
  "media.whooshkaa.com"
];

String json1 = '{"name":"Foo Service","product":"null","method":"null"}';
String json2 = '{"name":"DNS Service","product":"null","method":"null"}';
String json3 = '{"name":"NTP Service","product":"null","method":"null"}';

ServiceForPresentaion service1 =
    ServiceForPresentaion("Foo Service", "null", "null");
ServiceForPresentaion service2 =
    ServiceForPresentaion("DNS Service", "null", "null");
ServiceForPresentaion service3 =
    ServiceForPresentaion("NTP Service", "null", "null");

List<ServiceForPresentaion> services = [service1, service2, service3];

DeviceForPresentation testDevice1 = DeviceForPresentation(
    "Light Bulb Livingroom",
    "Foo MUD",
    "0.1",
    "192.168.1.2",
    "https://sc01.alicdn.com/kf/U7de314ba395248e7be6b6338c7d2e22cw.jpg_350x350.jpg",
    "https://lighting.example.com/lightbulb2000",
    "NoOneHasSignedThis",
    "https://lighting.example.com/documentation",
    services,
    allowedDNSRequests);

DeviceForPresentation testDevice2 = DeviceForPresentation(
    "Light Bulb Bedroom",
    "Foo MUD",
    "0.1",
    "192.168.1.2",
    "https://sc01.alicdn.com/kf/U7de314ba395248e7be6b6338c7d2e22cw.jpg_350x350.jpg",
    "https://lighting.example.com/lightbulb2000",
    "NoOneHasSignedThis",
    "https://lighting.example.com/documentation",
    services,
    allowedDNSRequests);

DeviceForPresentation testDevice3 = DeviceForPresentation(
    "Light Bulb Kidsroom",
    "Foo MUD",
    "0.1",
    "192.168.1.2",
    "https://sc01.alicdn.com/kf/U7de314ba395248e7be6b6338c7d2e22cw.jpg_350x350.jpg",
    "https://lighting.example.com/lightbulb2000",
    "NoOneHasSignedThis",
    "https://lighting.example.com/documentation",
    services,
    allowedDNSRequests);

DeviceForPresentation testDevice4 = DeviceForPresentation(
    "Light Bulb Hallway",
    "Foo MUD",
    "0.1",
    "192.168.1.2",
    "https://sc01.alicdn.com/kf/U7de314ba395248e7be6b6338c7d2e22cw.jpg_350x350.jpg",
    "https://lighting.example.com/lightbulb2000",
    "NoOneHasSignedThis",
    "https://lighting.example.com/documentation",
    services,
    allowedDNSRequests);

var devicesForPresentation = <DeviceForPresentation>[
  testDevice1,
  testDevice2,
  testDevice3,
  testDevice4
];

/// this is for all the clipart pictures
/// is used in chooseClipArt.dart
final List<String> allClipArts = [
  'resources/clipart/cloud.svg',
  'resources/clipart/desktop_mac.svg',
  'resources/clipart/desktop_windows.svg',
  'resources/clipart/lamp.svg',
  'resources/clipart/laptop.svg',
  'resources/clipart/laptop_chromebook.svg',
  'resources/clipart/laptop_mac.svg',
  'resources/clipart/laptop_windows.svg',
  'resources/clipart/lightning.svg',
  'resources/clipart/music_note.svg',
  'resources/clipart/music_note_beamed.svg',
  'resources/clipart/phone_android.svg',
  'resources/clipart/phone_iphone.svg',
  'resources/clipart/router.svg',
  'resources/clipart/smartphone.svg',
  'resources/clipart/speaker.svg',
  'resources/clipart/sun.svg',
  'resources/clipart/thermometer.svg',
  'resources/clipart/tv.svg'
];

class Constant{
  bool get getExpertMode{
    return expertMode;
  }
}

