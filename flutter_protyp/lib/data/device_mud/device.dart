import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_protyp/data/device_mud/mudData.dart';

// This class is a data construct for a device
/// This is a Test to see if this is a viable option to convert json to dartClass
/// idea: https://www.youtube.com/watch?v=8fFoLs9qVQA

part 'device.g.dart';

@JsonSerializable(explicitToJson: true)
class Device {
  ///systeminfo = Gerätename, name = MUD-Name, software_rev = Software Version,
  String hostname,
      ip_addr,
      last_interaction,
      mac_addr,
      mud_url,
      vendor_class,
      roomname,
      roomcolor,
      type,
      clipart;

  int id;
  MUDData mud_data;

  Device(
      this.hostname,
      this.ip_addr,
      this.last_interaction,
      this.mac_addr,
      this.mud_url,
      this.vendor_class,
      this.roomname,
      this.roomcolor,
      this.clipart,
      this.id,
      this.mud_data);

  factory Device.fromJson(Map<String, dynamic> data) => _$DeviceFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
