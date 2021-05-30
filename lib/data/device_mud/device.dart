import 'package:flutter_protyp/data/device_mud/room.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_protyp/data/device_mud/mudData.dart';

/// This class is a data construct for a device

part 'device.g.dart';

@JsonSerializable(explicitToJson: true)
class Device {
  String hostname,
      name,
      type,
      ipv4_addr,
      ipv6_addr,
      last_interaction,
      mac_addr,
      mud_url,
      vendor_class,
      clipart;
  int id;
  Room room;
  MUDData mud_data;

  Device(
      this.hostname,
      this.name,
      this.type,
      this.ipv4_addr,
      this.ipv6_addr,
      this.last_interaction,
      this.mac_addr,
      this.mud_url,
      this.vendor_class,
      this.clipart,
      this.id,
      this.room,
      this.mud_data);

  factory Device.fromJson(Map<String, dynamic> data) => _$DeviceFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
