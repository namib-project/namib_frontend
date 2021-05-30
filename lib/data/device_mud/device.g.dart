// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device(
    json['hostname'] as String,
    json['name'] as String,
    json['type'] as String,
    json['ipv4_addr'] as String,
    json['ipv6_addr'] as String,
    json['last_interaction'] as String,
    json['mac_addr'] as String,
    json['mud_url'] as String,
    json['vendor_class'] as String,
    json['clipart'] as String,
    json['id'] as int,
    json['room'] == null
        ? null
        : Room.fromJson(json['room'] as Map<String, dynamic>),
    json['mud_data'] == null
        ? null
        : MUDData.fromJson(json['mud_data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'hostname': instance.hostname,
      'name': instance.name,
      'type': instance.type,
      'ipv4_addr': instance.ipv4_addr,
      'ipv6_addr': instance.ipv6_addr,
      'last_interaction': instance.last_interaction,
      'mac_addr': instance.mac_addr,
      'mud_url': instance.mud_url,
      'vendor_class': instance.vendor_class,
      'clipart': instance.clipart,
      'id': instance.id,
      'room': instance.room?.toJson(),
      'mud_data': instance.mud_data?.toJson(),
    };
