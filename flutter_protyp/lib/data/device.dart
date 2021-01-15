import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_protyp/data/mudservice.dart';

/// This is a Test to see if this is a viable option to convert json to dartClass
/// idea: https://www.youtube.com/watch?v=8fFoLs9qVQA

part 'device.g.dart';

@JsonSerializable(explicitToJson: true)
class Device {
  ///systeminfo = Gerätename, name = MUD-Name, software_rev = Software Version,
  String systeminfo, name, software_rev, ipv4_addr, image, mud_url, mud_signature, documentation;
  List<MUDService> services;
  List<String> allowedDNSRequests;


  Device({
      this.systeminfo,
      this.name,
      this.software_rev,
      this.ipv4_addr,
      this.image,
      this.mud_url,
      this.mud_signature,
      this.documentation,
      this.services,
      this.allowedDNSRequests});

  Device.usual(this.systeminfo,
      this.name,
      this.software_rev,
      this.ipv4_addr,
      this.image,
      this.mud_url,
      this.mud_signature,
      this.documentation,
      this.services,
      this.allowedDNSRequests);

  factory Device.fromJson(Map<String, dynamic> data) => _$DeviceFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
