// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device(
    json['hostname'] as String,
    json['ip_addr'] as String,
    json['last_interaction'] as String,
    json['mac_addr'] as String,
    json['mud_url'] as String,
    json['vendor_class'] as String,
    json['room'] as String,
    json['id'] as int,
    json['mud_data'] == null
        ? null
        : MUDData.fromJson(json['mud_data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'hostname': instance.hostname,
      'ip_addr': instance.ip_addr,
      'last_interaction': instance.last_interaction,
      'mac_addr': instance.mac_addr,
      'mud_url': instance.mud_url,
      'vendor_class': instance.vendor_class,
      'room': instance.room,
      'id': instance.id,
      'mud_data': instance.mud_data?.toJson(),
    };
