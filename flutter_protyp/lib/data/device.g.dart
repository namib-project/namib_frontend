// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device(
    systeminfo: json['systeminfo'] as String,
    name: json['name'] as String,
    software_rev: json['software_rev'] as String,
    ipv4_addr: json['ipv4_addr'] as String,
    image: json['image'] as String,
    mud_url: json['mud_url'] as String,
    mud_signature: json['mud_signature'] as String,
    documentation: json['documentation'] as String,
    services: (json['services'] as List)
        ?.map((e) =>
            e == null ? null : MUDService.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    allowedDNSRequests:
        (json['allowedDNSRequests'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'systeminfo': instance.systeminfo,
      'name': instance.name,
      'software_rev': instance.software_rev,
      'ipv4_addr': instance.ipv4_addr,
      'image': instance.image,
      'mud_url': instance.mud_url,
      'mud_signature': instance.mud_signature,
      'documentation': instance.documentation,
      'services': instance.services?.map((e) => e?.toJson())?.toList(),
      'allowedDNSRequests': instance.allowedDNSRequests,
    };
