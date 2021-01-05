import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// This is a Test to see if this is a viable option to convert json to dartClass
/// idea: https://www.youtube.com/watch?v=8fFoLs9qVQA

part 'device.g.dart';

@JsonSerializable()
class Device {
  String deviceName, mudName;

  Device({this.deviceName, this.mudName});

  factory Device.fromJson(Map<String, dynamic> data) => _$DeviceFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
